import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.model.freezed.dart';
part 'expense.model.g.dart';

@freezed
abstract class ExpenseModel with _$ExpenseModel {
  const factory ExpenseModel({
    required String id,
    required String accountId,
    required String category,
    required DateTime date,
    required double amount,
  }) = _ExpenseModel;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);
}
