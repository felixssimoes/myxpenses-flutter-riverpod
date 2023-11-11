import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'core.providers.g.dart';

@Riverpod(keepAlive: true)
Uuid uuidGenerator(UuidGeneratorRef _) => const Uuid();

@riverpod
initialization(InitializationRef ref) {
  ref.read(dateIntervalServiceProvider);
}
