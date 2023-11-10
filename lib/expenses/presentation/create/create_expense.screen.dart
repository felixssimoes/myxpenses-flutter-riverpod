import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/presentation/create/create_expense.controller.dart';

import '../widgets/expense_amount.dart';
import '../widgets/expense_category.dart';
import '../widgets/expense_date.dart';

class CreateExpenseScreen extends ConsumerStatefulWidget {
  const CreateExpenseScreen({
    required this.accountId,
    super.key,
  });

  final String accountId;

  @override
  ConsumerState<CreateExpenseScreen> createState() =>
      _CreateExpenseScreenState();
}

class _CreateExpenseScreenState extends ConsumerState<CreateExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();
  final _amountController = TextEditingController();
  var _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    ref.listen(
      createExpenseControllerProvider(accountId: widget.accountId),
      (_, state) => state.showAlertDialogOnError(context),
    );
    final accountValue = ref.watch(accountProvider(widget.accountId));
    final state = ref.watch(createExpenseControllerProvider(
      accountId: widget.accountId,
    ));
    return Scaffold(
      appBar: AppBar(title: const Text('New Expense')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              width: double.infinity,
              height: 30,
              child: Center(
                child:
                    Text('Account: ${accountValue.valueOrNull?.name ?? '???'}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  ExpenseCategoryFormField(controller: _categoryController),
                  ExpenseAmountFormField(controller: _amountController),
                  ExpenseDateFormField(
                    startDate: _date,
                    onDateChanged: (date) => setState(() => _date = date),
                  ),
                  ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              ref
                                  .read(createExpenseControllerProvider(
                                    accountId: widget.accountId,
                                  ).notifier)
                                  .createExpense(
                                    widget.accountId,
                                    _categoryController.text,
                                    _amountController.text,
                                    _date,
                                  );
                            }
                          },
                    child: const Text('Create Expense'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
