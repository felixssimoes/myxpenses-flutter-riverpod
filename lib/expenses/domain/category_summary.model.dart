import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_summary.model.freezed.dart';
part 'category_summary.model.g.dart';

@freezed
abstract class CategorySummary with _$CategorySummary {
  const factory CategorySummary({
    required String category,
    required double total,
    required int expenseCount,
  }) = _CategorySummary;

  factory CategorySummary.fromJson(Map<String, dynamic> json) =>
      _$CategorySummaryFromJson(json);
}
