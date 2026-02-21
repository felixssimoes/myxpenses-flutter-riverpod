import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/accounts.dart';

class AccountListTile extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultAccountId = ref.watch(defaultAccountIdProvider);

    Widget buildDefaultIndicator() {
      return defaultAccountId.when(
        data: (defaultId) {
          if (defaultId == account.id) {
            return const Icon(
              Icons.star_rounded,
              color: Colors.amber,
              size: 18,
            );
          }

          return const SizedBox(width: 18);
        },
        loading: () => const SizedBox(
          // keeps trailing layout stable while loading
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        error: (error, stackTrace) => IconButton(
          padding: EdgeInsets.zero,
          iconSize: 18,
          tooltip: 'Retry loading default account',
          onPressed: () => ref.invalidate(defaultAccountIdProvider),
          icon: const Icon(
            Icons.error_outline,
            color: Colors.redAccent,
          ),
        ),
      );
    }

    return ListTile(
      title: Text(account.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildDefaultIndicator(),
          const SizedBox(width: 8),
          Text(total.toStringAsFixed(2)),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: onTap,
    );
  }
}
