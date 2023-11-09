import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/core/core.dart';

extension AsyncValueUI on AsyncValue {
  Future<void> showAlertDialogOnError(BuildContext context) async {
    if (!isLoading && hasError) {
      await showExceptionAlertDialog(
        context: context,
        exception: error,
      );
    }
  }
}
