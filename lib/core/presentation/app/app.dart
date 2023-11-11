import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/core/core.dart';

class MyXpensesApp extends ConsumerWidget {
  const MyXpensesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initializationProvider, (_, __) {});

    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'myXpenses',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      routerConfig: router.routerConfig,
    );
  }
}
