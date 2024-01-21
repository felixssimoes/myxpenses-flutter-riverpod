import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'db_expenses.repository.dart';
import 'expenses.repository.dart';

part 'expenses.data.g.dart';

@Riverpod(keepAlive: true)
ExpensesRepository expensesRepository(ExpensesRepositoryRef ref) =>
    DBExpensesRepository(ref);
