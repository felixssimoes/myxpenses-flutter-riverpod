import 'package:drift/drift.dart';

/// Database schema migrations are organized by from->to versions here.
/// Keep individual steps small and idempotent when possible.

/// Migrates schema from version 1 to 2.
///
/// v2 notes:
/// - No structural table changes at the moment.
/// - Helpful indexes are created in `beforeOpen` with IF NOT EXISTS.
Future<void> migrateFrom1To2(Migrator m) async {
  // Example placeholder for future changes. If we add columns or tables,
  // declare them here using `m.addColumn(...)`, `m.createTable(...)`, etc.
  // For now, no-op.
}
