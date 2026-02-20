import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_interval.repository.g.dart';

enum DateIntervalType { day, week, month }

typedef DateInterval = ({
  DateIntervalType type,
  DateTime startDate,
  DateTime endDate,
});

@Riverpod(keepAlive: true)
DateIntervalRepository dateIntervalRepository(Ref ref) =>
    DateIntervalRepository();

class DateIntervalRepository {
  DateInterval? _dateInterval;

  DateInterval? get dateInterval => _dateInterval;

  void setDateInterval(DateInterval dateInterval) {
    _dateInterval = dateInterval;
  }
}
