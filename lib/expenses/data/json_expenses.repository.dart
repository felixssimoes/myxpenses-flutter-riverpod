import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/expense.model.dart';
import 'expenses.repository.dart';

part 'json_expenses.repository.freezed.dart';
part 'json_expenses.repository.g.dart';

class JsonExpensesRepository implements ExpensesRepository {
  var _expenses = const _ExpensesModel(items: []);

  @override
  Future<List<ExpenseModel>> loadExpenses({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('expenses');
    if (data == null) {
      _expenses = const _ExpensesModel(items: []);
      return [];
    }

    _expenses = _ExpensesModel.fromJson(json.decode(data));
    final adjustedStartDate =
        startDate.subtract(const Duration(microseconds: 1));
    return _expenses.items
        .where((e) =>
            e.accountId == accountId &&
            e.date.isAfter(adjustedStartDate) &&
            e.date.isBefore(endDate))
        .toList();
  }

  @override
  Future<ExpenseModel?> loadExpense({required String id}) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('expenses');
    if (data == null) {
      _expenses = const _ExpensesModel(items: []);
      return null;
    }

    _expenses = _ExpensesModel.fromJson(json.decode(data));
    try {
      return _expenses.items.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> insertExpense(ExpenseModel expense) async {
    await _update([..._expenses.items, expense]);
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    final index = _expenses.items.indexWhere((a) => a.id == expense.id);
    if (index == -1) {
      throw Exception('Expense not found');
    }
    final exps = List<ExpenseModel>.from(_expenses.items);
    exps[index] = expense;
    await _update(exps);
  }

  @override
  Future<void> deleteExpense(ExpenseModel expense) async {
    await _update(_expenses.items.where((e) => e.id != expense.id).toList());
  }

  Future<void> _update(List<ExpenseModel> expenses) async {
    _expenses = _expenses.copyWith(items: expenses);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('expenses', json.encode(_expenses.toJson()));
  }
}

@freezed
class _ExpensesModel with _$ExpensesModel {
  const factory _ExpensesModel({
    required List<ExpenseModel> items,
  }) = __ExpensesModel;

  factory _ExpensesModel.fromJson(Map<String, dynamic> json) =>
      _$ExpensesModelFromJson(json);
}
