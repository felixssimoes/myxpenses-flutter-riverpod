import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'error_message_widget.dart';

typedef AsyncValueWrapperBuilder = Widget Function(
    BuildContext context, Widget child);

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    required this.value,
    required this.data,
    this.skipLoadingOnReload = false,
    this.skipLoadingOnRefresh = true,
    this.skipError = false,
    this.wrapperBuilder,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final bool skipLoadingOnReload;
  final bool skipLoadingOnRefresh;
  final bool skipError;
  final AsyncValueWrapperBuilder? wrapperBuilder;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) => _wrapIfNeeded(
        context,
        const Center(child: ErrorMessageWidget()),
      ),
      loading: () => _wrapIfNeeded(
        context,
        const Center(child: CircularProgressIndicator.adaptive()),
      ),
      skipLoadingOnReload: skipLoadingOnReload,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      skipError: skipError,
    );
  }

  Widget _wrapIfNeeded(BuildContext context, Widget child) {
    if (wrapperBuilder != null) {
      return wrapperBuilder!(context, child);
    }
    return child;
  }
}
