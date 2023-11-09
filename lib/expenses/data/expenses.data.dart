import 'package:myxpenses/expenses/data/json_expenses.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'expenses.repository.dart';

part 'expenses.data.g.dart';

@Riverpod(keepAlive: true)
ExpensesRepository expensesRepository(ExpensesRepositoryRef ref) =>
    JsonExpensesRepository();
