import 'package:myxpenses/core/core.providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'accounts.repository.dart';
import 'memory_accounts.repository.dart';

export 'accounts.repository.dart';

part 'accounts.data.g.dart';

@Riverpod(keepAlive: true)
AccountsRepository accountsRepository(AccountsRepositoryRef ref) =>
    MemoryAccountsRepository(uuidGenerator: ref.watch(uuidGeneratorProvider));
