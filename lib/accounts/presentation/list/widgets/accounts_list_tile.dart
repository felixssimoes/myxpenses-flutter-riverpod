import 'package:flutter/material.dart';
import 'package:myxpenses/accounts/domain/account.model.dart';

class AccountListTile extends StatelessWidget {
  const AccountListTile({
    required this.account,
    required this.total,
    required this.onTap,
    super.key,
  });

  final AccountModel account;
  final double total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(account.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(total.toStringAsFixed(2)),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: onTap,
    );
  }
}
