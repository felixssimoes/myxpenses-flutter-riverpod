## myXpenses – AI Coding Agent Playbook

Concise, project-specific guidance so an agent can contribute productively within minutes. Keep answers practical: cite concrete files & patterns. Avoid generic Flutter advice.

### 1. Core Architecture (Riverpod + Drift + Feature Folders)
- Entry: `lib/main.dart` boots `ProviderScope` with `RiverpodLogger` and `MyXpensesApp` (`core/presentation/app/app.dart`).
- Feature folders: `accounts/`, `expenses/`, `date_interval/` each split into `domain`, `data`, `application` (providers & services), `presentation` (UI). Core cross-cutting pieces live in `lib/core/`.
- State management: All providers use Riverpod code generation (`@riverpod` / `@Riverpod(keepAlive: true)`). Long‑lived only where justified: `databaseProvider`, `navigatorKeyProvider`. Everything else is auto-disposed.
- Navigation: Centralized in `core/presentation/navigation/app_router.dart` (wraps `go_router`). Use `appRouterProvider` methods instead of pushing routes directly in UI/business logic.
- Date scoping: Many queries depend on `dateIntervalProvider` (nullable). Always read it before querying expenses; if null return empty list (see `expenses.notifiers.dart`). Services invalidate dependent providers after mutations.

### 2. Persistence Layer
- Database: Drift (`core/data/drift.database.dart`) with tables `AccountsTable`, `ExpensesTable` only. Schema version currently `2` with migrations organized under `core/data/migrations/` (`migrations.dart`). Add structural changes via dedicated migrateFromXToY functions and bump `schemaVersion`.
- Index strategy & integrity: Index creation and `PRAGMA foreign_keys` + `PRAGMA integrity_check` executed in `beforeOpen` (idempotent). Don’t duplicate index creation elsewhere.
- Repositories: Abstract interfaces (`accounts/data/accounts.repository.dart`, `expenses/data/expenses.repository.dart`) + concrete DB implementations. Batch aggregation implemented via `loadAllAccountTotals` to prevent N+1 inside `accountsViewProvider`.
- Error mapping: Wrap DB calls in transactions & convert `SqliteException` to domain exceptions (`core/exceptions/app.exception.dart`). Maintain user‑friendly messages there; extend by adding new exception classes.

### 3. Services vs Notifiers
- Services (e.g. `AccountsService`, `ExpensesService`, `DateIntervalService`) encapsulate mutations + validation and perform targeted `ref.invalidate(...)` calls to refresh only affected providers.
- Read patterns: UI should prefer view providers (`accountsViewProvider`, `accountViewProvider`) for aggregated data rather than recomputing totals client side.
- Validation rules: Empty or duplicate account names → `InvalidAccountNameException` / `AccountNameAlreadyExistsException`; expense category non-empty and amount > 0 enforced in `ExpensesService._validateExpense`.

### 4. Provider Invalidations After Mutations
Follow existing patterns exactly:
- Creating/updating/deleting expenses: invalidate `expenseProvider`, `expensesProvider(accountId)`, `accountViewProvider(accountId)`, and `accountsViewProvider`.
- Creating/updating/deleting accounts: invalidate `accountsProvider` plus related expense & view providers (see `AccountsService.deleteAccount`).
New mutations must mirror this scoped invalidation approach—avoid broad `ref.invalidateAll()`.

### 5. Date Interval Mechanics
- Stored in lightweight in‑memory repository (`date_interval/data/date_interval.repository.dart`).
- Service (`date_interval.service.dart`) computes boundaries for day/week/month and navigates previous/next while preventing future intervals. Always use service methods to change intervals so dependent providers invalidate correctly.

### 6. Testing Conventions
- Robot pattern central helper: `test/robot.dart` with feature-specific robots under `test/accounts/presentation/...` & `test/expenses/presentation/...`.
- Mocks via Mockito `@GenerateMocks` per test file; helper generators produce `*.mocks.dart`.
- Use override of repositories when pumping widgets (`Robot.pumpApp` overrides providers). Replicate this for new feature tests instead of manually constructing the whole app.

### 7. Logging & Diagnostics
- Use `debugLog` / `debugLogError` (`core/utils/log.util.dart`) instead of print. Provider state transitions already logged by `RiverpodLogger` (avoid duplicating state dumps unless necessary).

### 8. Adding a New Feature Module (Pattern Example)
1. Create feature folder: `lib/<feature>/{domain,data,application,presentation}`.
2. Define domain models (consider `freezed` & `json_serializable` if serialization required; existing models sometimes use equatable instead—stay consistent with neighboring feature).
3. Add repository interface + implementation (DB or in‑memory). Keep DB specifics (Drift queries) only in the DB repository.
4. Expose read providers (`@riverpod Future<List<Model>> ...`) and a service provider for mutations + validation.
5. Invalidate only necessary providers after mutations.
6. Add tests: robot + mocks mirroring existing naming (`<feature>_list.screen_test.dart`).

### 9. Database Changes Workflow
- Add or modify tables: update `drift.database.dart` table classes, bump `schemaVersion`, implement migration function in `migrations.dart`, keep previous migrations intact.
- Non-structural indexes: keep in `beforeOpen` with `IF NOT EXISTS` (does not require schema bump). Structural changes (new columns/tables) must go through migrations.
- After adding columns, update repository mapping & services’ validation logic if needed.

### 10. Common Pitfalls to Avoid
- Don’t compute per-account totals individually inside loops; always use `loadAllAccountTotals` batch (see `accounts.notifiers.dart`).
- Don’t perform navigation directly with `GoRouter.of(context)` in business logic—delegate to `appRouterProvider` methods to keep routes centralized.
- Avoid `keepAlive: true` unless state must persist across navigation & rebuilds (pattern: only infra singletons like DB and navigator key).
- When adding providers that depend on date interval, handle the `null` case early and return empty list to keep UI resilient.

### 11. Useful Entry Points & Examples
- Aggregated accounts view logic: `accounts/application/accounts.notifiers.dart` (`accountsViewProvider`).
- Expense CRUD with scoped invalidation: `expenses/application/expenses.service.dart`.
- Account CRUD & cascade delete pattern: `accounts/application/accounts.service.dart`.
- Drift setup + integrity & indexing: `core/data/drift.database.dart`.
- Migrations scaffold: `core/data/migrations/migrations.dart`.
- Test robot bootstrap: `test/robot.dart`.

### 12. Tooling & Commands (macOS dev)
Run build runner for codegen (providers, freezed, JSON, drift if added):
```
flutter pub run build_runner watch --delete-conflicting-outputs
```
Run tests:
```
flutter test
```
Format & analyze (uses `analysis_options.yaml` + `riverpod_lint`):
```
flutter format . && flutter analyze
```

### 13. Extending Exceptions & Error Surfacing
- Add new exception subclasses in `core/exceptions/app.exception.dart` and throw them from services/repositories. UI dialogs depend on consistent `code` & `message` fields.

### 14. git
- Use meaningful commit messages that describe the changes made. Always start with a summary of the change in the first line and add details in the following lines if necessary.

### 15. When Unsure
- Prefer mirroring an existing feature (accounts or expenses) rather than inventing a new pattern.
- Search for similar provider/service names before introducing new ones to stay consistent.

---
Questions / unclear patterns? Open an issue or ask for clarification; keep this file updated when introducing architectural changes (new tables, cross-cutting services, or provider invalidation rules).
