import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myxpenses/date_interval/date_interval.dart';

final _formatter = DateFormat('yMd');
final _singleDayFormatter = DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY);
final _monthFormatter = DateFormat('MMMM yyyy');

class DateIntervalSelector extends ConsumerWidget {
  const DateIntervalSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interval = ref.watch(dateIntervalProvider);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Column(
        children: [
          SegmentedButton<DateIntervalType>(
            showSelectedIcon: false,
            selected: {interval.type},
            segments: const [
              ButtonSegment(
                value: DateIntervalType.day,
                label: Text('Day'),
              ),
              ButtonSegment(
                value: DateIntervalType.week,
                label: Text('Week'),
              ),
              ButtonSegment(
                value: DateIntervalType.month,
                label: Text('Month'),
              ),
            ],
            onSelectionChanged: (typeSet) => ref
                .read(dateIntervalServiceProvider)
                .setType(typeSet.firstOrNull ?? DateIntervalType.day),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_left),
                onPressed: () => ref
                    .read(dateIntervalServiceProvider)
                    .selectPreviousInterval(),
              ),
              Text(_buildDateIntervalText(interval)),
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

  String _buildDateIntervalText(DateInterval interval) {
    final (:type, :startDate, :endDate) = interval;
    switch (type) {
      case DateIntervalType.day:
        return _buildDateIntervalTextForDay(startDate);
      case DateIntervalType.week:
        return _buildDateIntervalTextForWeek(startDate, endDate);
      case DateIntervalType.month:
        return _buildDateIntervalTextForMonth(startDate);
    }
  }

  String _buildDateIntervalTextForDay(DateTime date) {
    return _singleDayFormatter.format(date);
  }

  String _buildDateIntervalTextForWeek(DateTime startDate, DateTime endDate) {
    return '${_formatter.format(startDate)} - ${_formatter.format(endDate)}';
  }

  String _buildDateIntervalTextForMonth(DateTime date) {
    final start = DateTime(date.year, date.month);
    return _monthFormatter.format(start);
  }
}
