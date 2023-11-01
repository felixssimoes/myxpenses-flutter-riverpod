import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/core/core.dart';

import '../widgets/account_name_form_field.dart';
import 'create_account.controller.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      createAccountControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(createAccountControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('New Account')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AccountNameFormField(
                    enabled: !state.isLoading,
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
                                .read(createAccountControllerProvider.notifier)
                                .createAccount(_nameController.text);
                          },
                    child: const Text('Create Account'),
                  ),
                ],
              ),
            ),
            if (state.isLoading) const LoadingOverlay(),
          ],
        ),
      ),
    );
  }
}
