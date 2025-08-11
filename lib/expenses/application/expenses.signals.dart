import 'package:riverpod/riverpod.dart';

/// A lightweight signal that bumps whenever expenses mutate.
/// Providers that derive totals can watch this to refresh on changes
/// without coupling to repository/DB providers.
final expensesMutationTickProvider = StateProvider<int>((ref) => 0);
