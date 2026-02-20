import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/domain/category_summary.model.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_summaries.notifier.g.dart';

@riverpod
Future<List<CategorySummary>> categorySummaries(
  Ref ref, {
  required String accountId,
  required DateInterval dateInterval,
}) async {
  final repository = ref.watch(expensesRepositoryProvider);
  final expenses = await repository.loadExpenses(
    accountId: accountId,
    startDate: dateInterval.startDate,
    endDate: dateInterval.endDate,
  );

  if (expenses.isEmpty) {
    return [];
  }

  final Map<String, List<double>> categoryExpenses = {};
  double grandTotal = 0.0;
  int totalCount = 0;

  for (final expense in expenses) {
    categoryExpenses.putIfAbsent(expense.category, () => []);
    categoryExpenses[expense.category]!.add(expense.amount);
    grandTotal += expense.amount;
    totalCount++;
  }

  final summaries = categoryExpenses.entries.map((entry) {
    final category = entry.key;
    final amounts = entry.value;
    final total = amounts.reduce((a, b) => a + b);
    final count = amounts.length;

    return CategorySummary(
      category: category,
      total: total,
      expenseCount: count,
    );
  }).toList();

  summaries.sort((a, b) => b.total.compareTo(a.total));

  final allCategoriesSummary = CategorySummary(
    category: 'All categories',
    total: grandTotal,
    expenseCount: totalCount,
  );

  return [allCategoriesSummary, ...summaries];
}
