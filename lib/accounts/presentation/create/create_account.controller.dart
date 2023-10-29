import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_account.controller.g.dart';

@riverpod
class CreateAccountController extends _$CreateAccountController {
  @override
  Future<void> build() async {}

  Future<void> createAccount(String name) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(accountsRepositoryProvider).createAccount(name: name);
      ref.read(appRouterProvider).goBack();
    });
  }
}
