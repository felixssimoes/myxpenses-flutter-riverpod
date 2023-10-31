import 'package:mock_data/mock_data.dart';
import 'package:myxpenses/accounts/accounts.dart';

AccountModel mockAccountModel({
  String? id,
  String? name,
}) {
  return AccountModel(
    id: id ?? mockUUID(),
    name: name ?? mockName(),
  );
}
