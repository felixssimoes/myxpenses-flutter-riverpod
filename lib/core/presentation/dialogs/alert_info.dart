import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myxpenses/core/exceptions/app.exception.dart';

class AlertAction extends Equatable {
  const AlertAction({
    required this.title,
    this.isDefault = false,
    this.isDestructive = false,
    this.popOnPressed = true,
    this.onPressed,
    this.titleTextStyle,
    this.key,
  });

  factory AlertAction.ok({
    bool isDefault = true,
    VoidCallback? onPressed,
    bool popOnPressed = true,
  }) =>
      AlertAction(
        title: 'Ok',
        isDefault: isDefault,
        onPressed: onPressed,
        popOnPressed: popOnPressed,
      );

  factory AlertAction.cancel({
    bool isDefault = true,
    VoidCallback? onPressed,
    bool popOnPressed = true,
  }) =>
      AlertAction(
        title: 'Cancel',
        isDefault: isDefault,
        onPressed: onPressed,
        popOnPressed: popOnPressed,
      );

  final String title;
  final VoidCallback? onPressed;
  final bool isDefault;
  final bool isDestructive;
  final bool popOnPressed;
  final TextStyle? titleTextStyle;
  final Key? key;

  @override
  List<Object?> get props => [
        title,
        isDefault,
        isDestructive,
        popOnPressed,
      ];

  void doOnPressed(BuildContext context) {
    if (popOnPressed) {
      Navigator.pop(context);
    }
    onPressed?.call();
  }
}

class AlertInfo extends Equatable {
  AlertInfo({
    this.title,
    this.text,
    this.panelChild,
    this.useSystemAlert = false,
    List<AlertAction>? actions,
    this.barrierDismissible,
    this.onBarrierDismissed,
  }) : actions = actions ?? [AlertAction.ok()];

  factory AlertInfo.fromException(
    dynamic exception, {
    String? title,
  }) {
    if (exception is AppException) {
      return AlertInfo(
        title: title ?? 'Error',
        text: exception.message,
      );
    }
    return AlertInfo(
      title: 'Error',
      text: 'Something went wrong. Please try again.',
    );
  }

  final String? title;
  final String? text;
  final bool useSystemAlert;
  final List<AlertAction> actions;
  final bool? barrierDismissible;
  final VoidCallback? onBarrierDismissed;

  /// widget to be displayed above the [title] Text
  final Widget? panelChild;

  @override
  List<Object?> get props => [
        title,
        text,
        actions,
        useSystemAlert,
        panelChild?.key,
      ];
}
