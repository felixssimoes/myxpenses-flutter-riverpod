import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/default_account.repository.dart';
import '../data/preferences_default_account.repository.dart';
import 'default_account.service.dart';

part 'default_account.providers.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) =>
    SharedPreferences.getInstance();

@Riverpod(keepAlive: true)
Future<DefaultAccountRepository> defaultAccountRepository(Ref ref) async {
  final preferences = await ref.watch(sharedPreferencesProvider.future);
  return PreferencesDefaultAccountRepository(preferences);
}

@riverpod
DefaultAccountService defaultAccountService(Ref ref) {
  return DefaultAccountService(
    ref: ref,
    repositoryLoader: () => ref.read(defaultAccountRepositoryProvider.future),
    onDefaultAccountChanged: () => ref.invalidate(defaultAccountIdProvider),
  );
}

@riverpod
Future<String?> defaultAccountId(Ref ref) async {
  final repository = await ref.watch(defaultAccountRepositoryProvider.future);
  return repository.getDefaultAccountId();
}
