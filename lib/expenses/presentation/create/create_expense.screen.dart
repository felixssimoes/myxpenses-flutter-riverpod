import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/presentation/create/create_expense.controller.dart';

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
  final _dateFormat = DateFormat('EEEE, MMMM d, yyyy');
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
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      icon: Icon(Icons.category),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a category';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                        labelText: 'Amount', icon: Icon(Icons.attach_money)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      final parsedValue = double.tryParse(value);
                      if (parsedValue == null || parsedValue <= 0) {
                        return 'Please enter a valid amount';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.calendar_today),
                      Text(_dateFormat.format(_date)),
                      ElevatedButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _date,
                            firstDate: DateTime(0),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            setState(() {
                              _date = date;
                            });
                          }
                        },
                        child: const Text('...'),
                      ),
                    ],
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
