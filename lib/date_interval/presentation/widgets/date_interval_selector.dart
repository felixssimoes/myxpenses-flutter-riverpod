import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myxpenses/date_interval/date_interval.dart';

final _formatter = DateFormat('dd/MM/yyy');

class DateIntervalSelector extends ConsumerWidget {
  const DateIntervalSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_left),
                onPressed: () => ref
                    .read(dateIntervalServiceProvider)
                    .selectPreviousInterval(),
              ),
              Text(
                  _formatter.format(ref.watch(dateIntervalProvider).startDate)),
              Text(_formatter.format(ref.watch(dateIntervalProvider).endDate)),
              IconButton(
                icon: const Icon(Icons.arrow_right),
                onPressed: () =>
                    ref.read(dateIntervalServiceProvider).selectNextInterval(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
