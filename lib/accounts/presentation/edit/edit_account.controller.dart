import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_account.controller.g.dart';

@riverpod
class EditAccountController extends _$EditAccountController {
  @override
  Future<void> build() async {}

  Future<void> updateAccount({
    required String accountId,
    required String name,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final account = await ref.read(accountProvider(accountId).future);
      await ref
          .read(accountsRepositoryProvider)
          .updateAccount(account: account.copyWith(name: name));
      ref.read(appRouterProvider).goBack();
    });
  }
}
