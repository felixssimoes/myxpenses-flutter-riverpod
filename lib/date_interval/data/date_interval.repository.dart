import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_interval.repository.g.dart';

enum DateIntervalType { day, week, month }

typedef DateInterval = ({
  DateIntervalType type,
  DateTime startDate,
  DateTime endDate,
});

@Riverpod(keepAlive: true)
DateIntervalRepository dateIntervalRepository(DateIntervalRepositoryRef ref) =>
    DateIntervalRepository();

class DateIntervalRepository {
  var _dateInterval = (
    type: DateIntervalType.day,
    startDate: DateTime.now(),
    endDate: DateTime.now(),
  );

  DateInterval get dateInterval => _dateInterval;

  void setDateInterval(DateInterval dateInterval) {
    _dateInterval = dateInterval;
  }
}
