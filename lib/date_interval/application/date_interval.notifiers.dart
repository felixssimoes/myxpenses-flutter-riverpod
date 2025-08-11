import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_interval.notifiers.g.dart';

@riverpod
DateInterval? dateInterval(Ref ref) =>
    ref.watch(dateIntervalRepositoryProvider).dateInterval;
