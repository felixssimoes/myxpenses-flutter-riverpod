import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'accounts.repository.dart';
import 'db_accounts.repository.dart';

export 'accounts.repository.dart';

part 'accounts.data.g.dart';

@Riverpod(keepAlive: true)
AccountsRepository accountsRepository(Ref ref) => DBAccountsRepository(ref);
