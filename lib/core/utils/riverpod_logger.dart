import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'log.util.dart';

class RiverpodLogger extends ProviderObserver {
  RiverpodLogger([this.printValue = false]);

  final bool printValue;

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final text = printValue
        ? '${provider.name ?? provider.runtimeType}: $newValue'
        : '${provider.name ?? provider.runtimeType}: ${newValue.runtimeType}';
    debugLog(text, name: 'state');
  }
}
