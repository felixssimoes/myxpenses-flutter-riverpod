import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/application/expenses.notifiers.dart';

import '../widgets/expense_amount.dart';
import '../widgets/expense_category.dart';
import '../widgets/expense_date.dart';
import 'edit_expense.controller.dart';

class EditExpenseScreen extends ConsumerStatefulWidget {
  const EditExpenseScreen({
    required this.expenseId,
    super.key,
  });

  final String expenseId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditExpenseScreenState();
}

class _EditExpenseScreenState extends ConsumerState<EditExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      editExpenseControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Expense'),
        actions: [
          IconButton(
            onPressed: _deleteExpenseWithConfirmation,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: AsyncValueWidget(
        value: ref.watch(expenseProvider(expenseId: widget.expenseId)),
        data: (expense) => Form(
          key: _formKey,
          child: Column(
            children: [
              if (expense != null)
                AsyncValueWidget(
                  value: ref.watch(accountProvider(expense.accountId)),
                  data: (account) => Container(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    width: double.infinity,
                    height: 30,
                    child: Center(
                      child: Text('Account: ${account?.name ?? '???'}'),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      ExpenseCategoryFormField(controller: _categoryController),
                      ExpenseAmountFormField(controller: _amountController),
                      ExpenseDateFormField(
                        startDate: _date,
                        onDateChanged: (date) => setState(() => _date = date),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _updateExpense,
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initData() async {
    final expense =
        await ref.read(expenseProvider(expenseId: widget.expenseId).future);
    if (expense != null) {
      setState(() {
        _categoryController.text = expense.category;
        _amountController.text = expense.amount.toString();
        _date = expense.date;
      });
    }
  }

  Future<void> _updateExpense() async {
    await ref.read(editExpenseControllerProvider.notifier).updateExpense(
          expenseId: widget.expenseId,
          category: _categoryController.text,
          amount: double.tryParse(_amountController.text) ?? 0,
          date: _date,
        );
  }

  Future<void> _deleteExpenseWithConfirmation() async {
    FocusScope.of(context).unfocus();
    await showAlertDialog(
      context: context,
      alertInfo: AlertInfo(
        title: 'Delete Expense',
        text: 'Are you sure you want to delete this expense?',
        actions: [
          AlertAction.cancel(),
          AlertAction(
            title: 'Delete',
            isDestructive: true,
            onPressed: () => ref
                .read(editExpenseControllerProvider.notifier)
                .deleteExpense(expenseId: widget.expenseId),
          ),
        ],
      ),
    );
  }
}
