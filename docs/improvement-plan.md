# MyXpenses Improvement Plan

*Generated on: August 10, 2025*

## Overview

This document outlines improvements and fixes for existing functionality in the MyXpenses Flutter application. These are code quality improvements and bug fixes that should be addressed to enhance the current features.

For new features and enhancements, see [Features Roadmap](./features-roadmap.md).

---

## 🔧 BUG FIXES & CODE QUALITY IMPROVEMENTS

These are improvements to existing functionality and code quality issues that should be addressed.

### 1. Performance Optimization (Critical)

**Issue**: N+1 query problem in `accountsView` provider
**Impact**: App becomes slow with multiple accounts
**Timeline**: 1-2 weeks
**Priority**: 🔴 HIGH

#### Current Problem
```dart
// lib/accounts/application/accounts.notifiers.dart
@Riverpod(keepAlive: true)
Future<List<AccountView>> accountsView(AccountsViewRef ref) async {
  final accounts = await ref.watch(accountsProvider.future);
  final accountsView = <AccountView>[];
  for (final account in accounts) {
    // This creates N+1 query problem - one query per account
    final expenses = await ref.watch(expensesProvider(accountId: account.id).future);
    final total = expenses.fold(0.0, (sum, expense) => sum + expense.amount);
    accountsView.add((account: account, total: total));
  }
  return accountsView;
}
```

#### Solution
- [x] Create a batch query method in `ExpensesRepository`
- [x] Implement SQL aggregation for account totals
- [x] Add database indexes for better performance

#### Implementation Steps
1. **Add batch totals method to ExpensesRepository**
```dart
// Add to lib/expenses/data/expenses.repository.dart
abstract class ExpensesRepository {
  // ... existing methods
  // Implemented as loadAllAccountTotals in the codebase
  Future<Map<String, double>> loadAllAccountTotals({
    required DateTime startDate,
    required DateTime endDate,
  });
}
```

2. **Implement in DBExpensesRepository**
```dart
// Update lib/expenses/data/db_expenses.repository.dart
@override
Future<Map<String, double>> loadAllAccountTotals({
  required DateTime startDate,
  required DateTime endDate,
}) async {
  final result = await _db.customSelect(
    '''
    SELECT account_id, SUM(amount) as total
    FROM expenses_table
    WHERE date >= ? AND date < ?
    GROUP BY account_id
    ''',
    variables: [
      Variable.withDateTime(startDate),
      Variable.withDateTime(endDate),
    ],
  ).get();

  return Map.fromEntries(
    result.map((row) => MapEntry(
      row.read<String>('account_id'),
      row.readNullable<double>('total') ?? 0.0,
    )),
  );
}
```

3. **Update accountsView provider**
```dart
// Update lib/accounts/application/accounts.notifiers.dart
@Riverpod(keepAlive: true)
Future<List<AccountView>> accountsView(AccountsViewRef ref) async {
  final accounts = await ref.watch(accountsProvider.future);
  final interval = ref.watch(dateIntervalProvider);

  if (interval == null || accounts.isEmpty) {
    return accounts.map((account) => (account: account, total: 0.0)).toList();
  }

  final totals = await ref.watch(expensesRepositoryProvider).loadAllAccountTotals(
    startDate: interval.startDate,
    endDate: interval.endDate,
  );

  return accounts.map((account) => (
    account: account,
    total: totals[account.id] ?? 0.0,
  )).toList();
}
```

4. **Add database indexes**
```dart
// Update lib/core/data/drift.database.dart
@override
MigrationStrategy get migration => MigrationStrategy(
  beforeOpen: (details) async {
    await customStatement('PRAGMA foreign_keys = ON');
    await customStatement('CREATE INDEX IF NOT EXISTS idx_expenses_account_date ON expenses_table(account_id, date)');
    await customStatement('CREATE INDEX IF NOT EXISTS idx_expenses_date ON expenses_table(date)');
  },
);
```

**Progress**: ✅ Done

---

### 2. Database Migration Strategy

**Issue**: No migration handling for schema changes
**Impact**: App crashes on schema updates
**Timeline**: 1 week
**Priority**: 🔴 HIGH

#### Implementation
- [x] Add migration strategy to Drift database
- [x] Create migration files structure
- [x] Add version tracking

#### Code Changes
```dart
// Update lib/core/data/drift.database.dart
@DriftDatabase(tables: [AccountsTable, ExpensesTable])
class MyXpensesDatabase extends _$MyXpensesDatabase {
  MyXpensesDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2; // Increment when schema changes

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // Example migration: Add new column
        // await m.addColumn(expensesTable, expensesTable.description);
      }
    },
    beforeOpen: (details) async {
      if (details.wasCreated) {
        // Initialize with default data if needed
      }
    },
  );
}
```

**Progress**: ✅ Done

---

### 3. Provider Lifecycle Management

**Issue**: Excessive use of `keepAlive: true` causing memory leaks
**Impact**: Memory usage grows over time
**Timeline**: 3-5 days
**Priority**: 🔴 HIGH

#### Solution
- [ ] Audit all providers with `keepAlive: true`
- [ ] Implement proper provider disposal
- [ ] Add provider dependency declarations

#### Changes Required
```dart
// Remove keepAlive from providers that don't need it
@Riverpod() // Remove keepAlive: true
Future<List<ExpenseModel>> expenses(ExpensesRef ref, {required String accountId}) async {
  // Add proper invalidation
  ref.onDispose(() {
    // Cleanup if needed
  });

  final interval = ref.watch(dateIntervalProvider);
  if (interval == null) return [];

  return ref.watch(expensesRepositoryProvider).loadExpenses(
    accountId: accountId,
    startDate: interval.startDate,
    endDate: interval.endDate,
  );
}
```

**Progress**: ⬜ Not Started

---

### 4. Enhanced Error Handling & Data Integrity

**Issue**: Limited error handling and data validation
**Impact**: Poor user experience when errors occur
**Timeline**: 1-2 weeks
**Priority**: 🟡 MEDIUM

#### Features to Implement
- [ ] Better error recovery for database operations
- [ ] Transaction rollback on failures
- [ ] Data validation at multiple layers
- [ ] User-friendly error messages

#### Implementation Plan
1. **Add robust error handling to repositories**
```dart
// lib/expenses/data/db_expenses.repository.dart
@override
Future<void> insertExpense(ExpenseModel expense) async {
  try {
    await _db.transaction(() async {
      await _db.into(_db.expensesTable).insert(
        ExpensesTableCompanion.insert(
          id: expense.id,
          accountId: expense.accountId,
          category: expense.category,
          date: expense.date,
          amount: expense.amount,
        ),
      );
    });
  } on SqliteException catch (e) {
    if (e.extendedResultCode == 2067) { // UNIQUE constraint failed
      throw DuplicateExpenseException();
    }
    throw DatabaseException('Failed to save expense: ${e.message}');
  } catch (e) {
    throw DatabaseException('Unexpected error: $e');
  }
}
```

2. **Add data integrity checks**
```dart
// lib/core/data/drift.database.dart
class MyXpensesDatabase extends _$MyXpensesDatabase {
  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      // Enable foreign key constraints
      await customStatement('PRAGMA foreign_keys = ON');

      // Verify data integrity
      final result = await customSelect('PRAGMA integrity_check').get();
      if (result.first.read<String>('integrity_check') != 'ok') {
        throw DatabaseCorruptionException();
      }
    },
  );
}
```

**Progress**: ⬜ Not Started

---

### 5. Code Quality & Technical Debt

**Timeline**: 1 week
**Priority**: 🟡 MEDIUM

#### Issues to Address
- [ ] **Hardcoded strings**: Move UI strings to localization
- [ ] **Missing validation**: Add input validation at form level
- [ ] **Inconsistent naming**: Standardize naming conventions
- [ ] **Missing documentation**: Add comprehensive code documentation

#### Implementation
```dart
// Example: Move hardcoded strings to constants
class AppStrings {
  static const String accountsTitle = 'Accounts';
  static const String noAccountsMessage = 'no accounts created yet';
  static const String createAccountButton = 'Create Account';
  // ... more strings
}

// Example: Add form validation
class AccountNameFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return AppStrings.accountNameRequired;
        }
        if (value.trim().length < 2) {
          return AppStrings.accountNameTooShort;
        }
        return null;
      },
      // ... rest of implementation
    );
  }
}
```

**Progress**: ⬜ Not Started

---

## 📊 TESTING IMPROVEMENTS

### Current Testing Status
- ✅ Widget tests with robot pattern
- ✅ Unit tests for basic functionality
- ❌ Integration tests
- ❌ Performance tests
- ❌ Golden tests

### Testing Roadmap
1. **Integration Tests** (1 week)
   - [ ] End-to-end user flows
   - [ ] Database integration tests

2. **Performance Tests** (3 days)
   - [ ] Large dataset performance
   - [ ] Memory usage tests

3. **Golden Tests** (1 week)
   - [ ] UI consistency tests
   - [ ] Cross-platform rendering

---

## 🔧 DevOps and Tooling

### CI/CD Pipeline
- [ ] GitHub Actions setup
- [ ] Automated testing
- [ ] Code coverage reports
- [ ] Automated deployment

### Code Quality Tools
- [ ] Additional lint rules
- [ ] Code coverage thresholds
- [ ] Dependency vulnerability scanning

---

## 📅 Implementation Timeline

### Phase 1 (Weeks 1-4): Critical Fixes
1. Week 1: Database migration strategy
2. Week 2: Provider lifecycle management
3. Week 3-4: Performance optimization (N+1 queries)

### Phase 2 (Weeks 5-8): Quality Improvements
1. Week 5-6: Error handling & data integrity
2. Week 7: Code quality & technical debt
3. Week 8: Testing improvements

---

## 🎯 Success Metrics

### Performance
- [ ] App startup time < 2 seconds
- [ ] Data loading time < 1 second for 1000+ expenses
- [ ] Memory usage < 100MB during normal operation

### User Experience
- [ ] All database operations complete successfully
- [ ] Zero data corruption incidents
- [ ] Forms validate input properly

### Code Quality
- [ ] Test coverage > 80%
- [ ] Zero critical security vulnerabilities
- [ ] Build time < 5 minutes
- [ ] No memory leaks detected

---

## 📝 Progress Tracking

### Completed Items
*Track completed improvements here*

### In Progress
*Track current work here*

### Blocked Items
*Track any blockers here*

---

## 🤝 Contributing Guidelines

When implementing these improvements:

1. **Follow existing architecture patterns**
2. **Write tests for new features**
3. **Update documentation**
4. **Consider backward compatibility**
5. **Test on multiple platforms**
6. **Review performance impact**

---

## 📚 Additional Resources

- [Flutter Performance Best Practices](https://docs.flutter.dev/perf/best-practices)
- [Riverpod Documentation](https://riverpod.dev/)
- [Drift Documentation](https://drift.simonbinder.eu/)
- [Flutter Testing Guide](https://docs.flutter.dev/testing)

---

*This document should be updated regularly as improvements are implemented and new requirements emerge.*
