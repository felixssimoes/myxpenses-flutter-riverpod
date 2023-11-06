import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/accounts/presentation/widgets/account_name_form_field.dart';
import 'package:myxpenses/core/core.dart';

import 'edit_account.controller.dart';

class EditAccountScreen extends ConsumerStatefulWidget {
  const EditAccountScreen({
    required this.accountId,
    super.key,
  });

  final String accountId;

  @override
  ConsumerState<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends ConsumerState<EditAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final accountValue = ref.read(accountProvider(widget.accountId));
    _nameController.text = accountValue.valueOrNull?.name ?? '';
  }

  Future<void> _deleteAccountWithConfirmation() async {
    FocusScope.of(context).unfocus();
    final theme = Theme.of(context);
    await showDialog(
      context: context,
      builder: (_) => AlertDialog.adaptive(
        title: const Text('Delete Account'),
        content: const Text('Are you sure you want to delete this account?'),
        actions: [
          TextButton(
            onPressed: () => ref.read(appRouterProvider).goBack(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => ref
                .read(editAccountControllerProvider.notifier)
                .deleteAccount(accountId: widget.accountId),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      editAccountControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    ref.listen(accountProvider(widget.accountId), (previous, next) {
      _nameController.text = next.valueOrNull?.name ?? '';
    });
    final state = ref.watch(editAccountControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
        actions: [
          IconButton(
            onPressed: state.isLoading ? null : _deleteAccountWithConfirmation,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AccountNameFormField(
                accountId: widget.accountId,
                controller: _nameController,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        await ref
                            .read(editAccountControllerProvider.notifier)
                            .updateAccount(
                              accountId: widget.accountId,
                              name: _nameController.text,
                            );
                      },
                child: const Text('Update Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
