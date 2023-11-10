import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_interval.service.g.dart';

@Riverpod(keepAlive: true)
DateIntervalService dateIntervalService(DateIntervalServiceRef ref) =>
    DateIntervalService(ref);

class DateIntervalService {
  DateIntervalService(this._ref);

  final Ref _ref;

  void setType(DateIntervalType newType) {
    _resetDatesForType(newType);
    _ref.invalidate(dateIntervalProvider);
  }

  void selectPreviousInterval() {
    var (:type, :startDate, :endDate) =
        _ref.read(dateIntervalRepositoryProvider).dateInterval;
    switch (type) {
      case DateIntervalType.day:
        endDate = startDate;
        startDate = startDate.subtract(const Duration(days: 1));
        break;
      case DateIntervalType.week:
        endDate = startDate;
        startDate = startDate.subtract(const Duration(days: 7));
        break;
      case DateIntervalType.month:
        endDate = startDate;
        startDate = DateTime(startDate.year, startDate.month - 1);
        break;
    }
    _ref.read(dateIntervalRepositoryProvider).setDateInterval((
      type: type,
      startDate: startDate,
      endDate: endDate,
    ));
    _ref.invalidate(dateIntervalProvider);
  }

  void selectNextInterval() {
    var (:type, :startDate, :endDate) =
        _ref.read(dateIntervalRepositoryProvider).dateInterval;

    switch (type) {
      case DateIntervalType.day:
        startDate = startDate.add(const Duration(days: 1));
        endDate = startDate.add(const Duration(days: 1));
        break;
      case DateIntervalType.week:
        startDate = startDate.add(const Duration(days: 7));
        endDate = startDate.add(const Duration(days: 7));
        break;
      case DateIntervalType.month:
        startDate = DateTime(startDate.year, startDate.month + 1);
        endDate = DateTime(startDate.year, startDate.month + 1);
        break;
    }

    if (startDate.isAfter(DateTime.now())) {
      return;
    }

    _ref.read(dateIntervalRepositoryProvider).setDateInterval((
      type: type,
      startDate: startDate,
      endDate: endDate,
    ));
    _ref.invalidate(dateIntervalProvider);
  }

  void _resetDatesForType(DateIntervalType newType) {
    final now = DateTime.now();
    late DateTime startDate, endDate;
    switch (newType) {
      case DateIntervalType.day:
        startDate = DateTime(now.year, now.month, now.day);
        endDate = startDate.add(const Duration(days: 1));
        break;

      case DateIntervalType.week:
        final today = DateTime(now.year, now.month, now.day);
        startDate = today.subtract(Duration(days: today.weekday));
        endDate = startDate.add(const Duration(days: 7));
        break;

      case DateIntervalType.month:
        startDate = DateTime(now.year, now.month);
        endDate = DateTime(now.year, now.month + 1);
        break;
    }
    _ref.read(dateIntervalRepositoryProvider).setDateInterval((
      type: newType,
      startDate: startDate,
      endDate: endDate,
    ));
  }
}
