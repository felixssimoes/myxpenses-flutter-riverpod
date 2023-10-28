import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'core.providers.g.dart';

@riverpod
Uuid uuidGenerator(UuidGeneratorRef _) => const Uuid();
