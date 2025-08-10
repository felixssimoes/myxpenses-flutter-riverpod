import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.model.freezed.dart';
part 'account.model.g.dart';

@freezed
abstract class AccountModel with _$AccountModel {
  const factory AccountModel({
    required String id,
    required String name,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}
