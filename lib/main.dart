import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/core/core.dart';

void main() {
  runApp(ProviderScope(
    observers: [RiverpodLogger(true)],
    child: const MyXpensesApp(),
  ));
}
