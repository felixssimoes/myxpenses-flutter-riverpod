// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_account.providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'25eceea0052302f519f44a896409ba30ede45562';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = FutureProvider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = FutureProviderRef<SharedPreferences>;
String _$defaultAccountRepositoryHash() =>
    r'c66cc45280ab4ecf3afdb44b38b70dd106b5ba6d';

/// See also [defaultAccountRepository].
@ProviderFor(defaultAccountRepository)
final defaultAccountRepositoryProvider =
    FutureProvider<DefaultAccountRepository>.internal(
  defaultAccountRepository,
  name: r'defaultAccountRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$defaultAccountRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DefaultAccountRepositoryRef
    = FutureProviderRef<DefaultAccountRepository>;
String _$defaultAccountServiceHash() =>
    r'cb3a6717bbcd1b5088e888ed3c44de98ac6f7b76';

/// See also [defaultAccountService].
@ProviderFor(defaultAccountService)
final defaultAccountServiceProvider =
    AutoDisposeProvider<DefaultAccountService>.internal(
  defaultAccountService,
  name: r'defaultAccountServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$defaultAccountServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DefaultAccountServiceRef
    = AutoDisposeProviderRef<DefaultAccountService>;
String _$defaultAccountIdHash() => r'48a32f443710ca302da12a24dfc27ebbc9b49b77';

/// See also [defaultAccountId].
@ProviderFor(defaultAccountId)
final defaultAccountIdProvider = AutoDisposeFutureProvider<String?>.internal(
  defaultAccountId,
  name: r'defaultAccountIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$defaultAccountIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DefaultAccountIdRef = AutoDisposeFutureProviderRef<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
