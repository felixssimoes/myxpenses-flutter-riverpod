import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_interval.notifiers.g.dart';

@Riverpod(keepAlive: true)
DateInterval dateInterval(DateIntervalRef ref) =>
    ref.watch(dateIntervalRepositoryProvider).dateInterval;
