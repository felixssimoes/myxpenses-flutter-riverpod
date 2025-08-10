import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'core.providers.g.dart';

@Riverpod(keepAlive: true)
Uuid uuidGenerator(Ref _) => const Uuid();

@riverpod
void initialization(Ref ref) {
  ref.read(dateIntervalServiceProvider);
}
