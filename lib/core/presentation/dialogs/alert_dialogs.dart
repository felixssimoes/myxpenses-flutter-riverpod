import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'alert_info.dart';

Future<bool?> showAlertDialog({
  required BuildContext context,
  required AlertInfo alertInfo,
}) async {
  final theme = Theme.of(context);
  return showDialog(
    context: context,
    barrierDismissible: alertInfo.barrierDismissible ?? false,
    builder: (context) => AlertDialog.adaptive(
      title: alertInfo.title != null ? Text(alertInfo.title!) : null,
      content: alertInfo.text != null ? Text(alertInfo.text!) : null,
      actions: alertInfo.actions
          .map(
            (action) => kIsWeb || !Platform.isIOS
                ? TextButton(
                    key: action.key,
                    style: TextButton.styleFrom(
                        foregroundColor: action.isDestructive
                            ? theme.colorScheme.error
                            : null),
                    child: Text(action.title),
                    onPressed: () => action.doOnPressed(context),
                  )
                : CupertinoDialogAction(
                    isDestructiveAction: action.isDestructive,
                    isDefaultAction: action.isDefault,
                    child: Text(action.title),
                    onPressed: () => action.doOnPressed(context),
                  ),
          )
          .toList(),
    ),
  );
}

Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      alertInfo: AlertInfo.fromException(exception),
    );

Future<void> showNotImplementedAlertDialog({required BuildContext context}) =>
    showAlertDialog(
      context: context,
      alertInfo: AlertInfo(title: 'Not implemented', text: 'Sorry!'),
    );
