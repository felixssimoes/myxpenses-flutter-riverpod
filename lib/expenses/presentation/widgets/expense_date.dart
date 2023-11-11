import 'package:flutter/material.dart';
import 'package:myxpenses/core/core.dart';

typedef DateChangedCallback = void Function(DateTime date);

class ExpenseDateFormField extends StatefulWidget {
  const ExpenseDateFormField({
    required this.startDate,
    required this.onDateChanged,
    super.key,
  });

  final DateTime startDate;
  final DateChangedCallback onDateChanged;

  @override
  State<ExpenseDateFormField> createState() => _ExpenseDateFormFieldState();
}

class _ExpenseDateFormFieldState extends State<ExpenseDateFormField> {
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _date = widget.startDate;
  }

  @override
  void didUpdateWidget(covariant ExpenseDateFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _date = widget.startDate;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.calendar_today),
        Text(longDateFormatter.format(_date)),
        ElevatedButton(
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _date,
              firstDate: DateTime(0),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              setState(() => _date = date);
              widget.onDateChanged(_date);
            }
          },
          child: const Text('...'),
        ),
      ],
    );
  }
}
