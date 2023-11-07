// Mocks generated by Mockito 5.4.2 from annotations
// in myxpenses/test/accounts/presentation/create/create_account.screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:flutter_riverpod/flutter_riverpod.dart' as _i2;
import 'package:go_router/go_router.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:myxpenses/accounts/accounts.dart' as _i4;
import 'package:myxpenses/core/presentation/navigation/app_router.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeRef_0<State extends Object?> extends _i1.SmartFake
    implements _i2.Ref<State> {
  _FakeRef_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGoRouter_1 extends _i1.SmartFake implements _i3.GoRouter {
  _FakeGoRouter_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAccountModel_2 extends _i1.SmartFake implements _i4.AccountModel {
  _FakeAccountModel_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AppRouter].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppRouter extends _i1.Mock implements _i5.AppRouter {
  MockAppRouter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Ref<Object?> get ref => (super.noSuchMethod(
        Invocation.getter(#ref),
        returnValue: _FakeRef_0<Object?>(
          this,
          Invocation.getter(#ref),
        ),
      ) as _i2.Ref<Object?>);

  @override
  _i3.GoRouter get routerConfig => (super.noSuchMethod(
        Invocation.getter(#routerConfig),
        returnValue: _FakeGoRouter_1(
          this,
          Invocation.getter(#routerConfig),
        ),
      ) as _i3.GoRouter);

  @override
  void goBack() => super.noSuchMethod(
        Invocation.method(
          #goBack,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void goHome() => super.noSuchMethod(
        Invocation.method(
          #goHome,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void openCreateAccount() => super.noSuchMethod(
        Invocation.method(
          #openCreateAccount,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void openAccountDetails(String? accountId) => super.noSuchMethod(
        Invocation.method(
          #openAccountDetails,
          [accountId],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void openEditAccount(String? accountId) => super.noSuchMethod(
        Invocation.method(
          #openEditAccount,
          [accountId],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [AccountsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAccountsRepository extends _i1.Mock
    implements _i4.AccountsRepository {
  MockAccountsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i4.AccountModel> get accounts => (super.noSuchMethod(
        Invocation.getter(#accounts),
        returnValue: <_i4.AccountModel>[],
      ) as List<_i4.AccountModel>);

  @override
  _i6.Stream<List<_i4.AccountModel>> get watchAccounts => (super.noSuchMethod(
        Invocation.getter(#watchAccounts),
        returnValue: _i6.Stream<List<_i4.AccountModel>>.empty(),
      ) as _i6.Stream<List<_i4.AccountModel>>);

  @override
  _i6.Future<_i4.AccountModel> createAccount({required String? name}) =>
      (super.noSuchMethod(
        Invocation.method(
          #createAccount,
          [],
          {#name: name},
        ),
        returnValue: _i6.Future<_i4.AccountModel>.value(_FakeAccountModel_2(
          this,
          Invocation.method(
            #createAccount,
            [],
            {#name: name},
          ),
        )),
      ) as _i6.Future<_i4.AccountModel>);

  @override
  _i6.Future<_i4.AccountModel> updateAccount(
          {required _i4.AccountModel? account}) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateAccount,
          [],
          {#account: account},
        ),
        returnValue: _i6.Future<_i4.AccountModel>.value(_FakeAccountModel_2(
          this,
          Invocation.method(
            #updateAccount,
            [],
            {#account: account},
          ),
        )),
      ) as _i6.Future<_i4.AccountModel>);

  @override
  _i6.Future<void> deleteAccount({required _i4.AccountModel? account}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteAccount,
          [],
          {#account: account},
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}
