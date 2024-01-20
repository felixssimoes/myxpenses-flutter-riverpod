import 'dart:io';

import 'package:mock_data/mock_data.dart';
import 'package:mockito/mockito.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/expenses.dart';

class MockHttpOverrides extends HttpOverrides {}

String mockEmail() => '${mockString()}@${mockString()}.${mockString(3)}';

Uri mockUri() => Uri.parse(mockUrl('*', true));
Uri mockFileUri() => Uri.parse(mockUrl('file', true));

class MockVoidCallback extends Mock {
  void call();
}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

AccountModel mockAccountModel({
  String? id,
  String? name,
}) {
  return AccountModel(
    id: id ?? mockUUID(),
    name: name ?? mockName(),
  );
}

ExpenseModel mockExpenseModel({
  String? id,
  String? accountId,
  String? category,
  DateTime? date,
  double? amount,
}) =>
    ExpenseModel(
      id: id ?? mockUUID(),
      accountId: accountId ?? mockUUID(),
      category: category ?? 'category',
      date: date ?? DateTime.now(),
      amount: amount ?? mockInteger(1, 100).toDouble(),
    );

DateInterval mockDateInterval({
  DateIntervalType? type,
  DateTime? startDate,
  DateTime? endDate,
}) =>
    (
      type: type ?? DateIntervalType.day,
      startDate: startDate ?? DateTime.now().subtract(const Duration(days: 1)),
      endDate: endDate ?? DateTime.now(),
    );
