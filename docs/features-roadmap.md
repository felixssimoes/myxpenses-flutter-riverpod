# MyXpenses New Features Roadmap

*Generated on: August 10, 2025*

## Overview

This document outlines new features and enhancements for the MyXpenses Flutter application. These are additions to the existing functionality that would expand the app's capabilities.

---

## ✨ NEW FEATURES & ENHANCEMENTS

### 1. Search and Filtering System

**Timeline**: 2 weeks
**Priority**: 🟡 MEDIUM

#### Features
- [ ] Search expenses by category, amount, date range
- [ ] Filter accounts and expenses
- [ ] Sort options (date, amount, category)
- [ ] Search history

#### Implementation
```dart
// lib/expenses/application/search_notifier.dart
@riverpod
class ExpenseSearchNotifier extends _$ExpenseSearchNotifier {
  @override
  ExpenseSearchState build() => const ExpenseSearchState();

  void updateQuery(String query) {
    state = state.copyWith(query: query);
  }

  void updateDateRange(DateTimeRange range) {
    state = state.copyWith(dateRange: range);
  }

  void updateCategoryFilter(String? category) {
    state = state.copyWith(categoryFilter: category);
  }
}

@freezed
class ExpenseSearchState with _$ExpenseSearchState {
  const factory ExpenseSearchState({
    @Default('') String query,
    DateTimeRange? dateRange,
    String? categoryFilter,
    @Default(ExpenseSortType.date) ExpenseSortType sortType,
    @Default(true) bool sortDescending,
  }) = _ExpenseSearchState;
}
```

#### UI Implementation
```dart
// lib/expenses/presentation/search/expense_search_screen.dart
class ExpenseSearchScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(expenseSearchNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search expenses...',
            border: InputBorder.none,
          ),
          onChanged: (query) => ref
              .read(expenseSearchNotifierProvider.notifier)
              .updateQuery(query),
        ),
      ),
      body: Column(
        children: [
          // Filter chips
          SearchFiltersRow(),

          // Results
          Expanded(
            child: SearchResultsList(),
          ),
        ],
      ),
    );
  }
}
```

**Progress**: ⬜ Not Started

---

### 2. Data Export Functionality

**Timeline**: 1-2 weeks
**Priority**: 🟡 MEDIUM

#### Features
- [ ] Export to CSV
- [ ] Export to PDF
- [ ] Share exported files
- [ ] Custom date ranges for export

#### Dependencies
```yaml
# Add to pubspec.yaml
dependencies:
  csv: ^5.0.2
  pdf: ^3.10.8
  share_plus: ^7.2.1
```

#### Implementation
```dart
// lib/core/services/export_service.dart
@riverpod
ExportService exportService(ExportServiceRef ref) => ExportService(ref);

class ExportService {
  ExportService(this._ref);
  final Ref _ref;

  Future<String> exportToCsv({
    required List<ExpenseModel> expenses,
    required DateTimeRange dateRange,
  }) async {
    final csv = const ListToCsvConverter();
    final data = [
      ['Date', 'Category', 'Amount', 'Account'],
      ...expenses.map((expense) => [
        expense.date.toIso8601String(),
        expense.category,
        expense.amount.toString(),
        expense.accountId,
      ]),
    ];
    return csv.convert(data);
  }

  Future<Uint8List> exportToPdf({
    required List<ExpenseModel> expenses,
    required AccountModel account,
    required DateTimeRange dateRange,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Expense Report', style: pw.TextStyle(fontSize: 24)),
              pw.Text('Account: ${account.name}'),
              pw.Text('Period: ${dateRange.start} - ${dateRange.end}'),
              pw.SizedBox(height: 20),

              // Expenses table
              pw.Table.fromTextArray(
                headers: ['Date', 'Category', 'Amount'],
                data: expenses.map((expense) => [
                  expense.date.toString().split(' ')[0],
                  expense.category,
                  '\$${expense.amount.toStringAsFixed(2)}',
                ]).toList(),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<void> shareExport(String filePath) async {
    await Share.shareXFiles([XFile(filePath)]);
  }
}
```

#### UI Integration
```dart
// Add to account details screen
FloatingActionButton(
  child: Icon(Icons.share),
  onPressed: () => _showExportDialog(context, ref),
)

void _showExportDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Export Data'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.table_chart),
            title: Text('Export as CSV'),
            onTap: () => _exportAsCsv(ref),
          ),
          ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text('Export as PDF'),
            onTap: () => _exportAsPdf(ref),
          ),
        ],
      ),
    ),
  );
}
```

**Progress**: ⬜ Not Started

---

### 3. Category Management System

**Timeline**: 1-2 weeks
**Priority**: 🟢 LOW

#### Features
- [ ] Predefined categories with icons
- [ ] Custom categories
- [ ] Category colors
- [ ] Category-based budgets

#### Data Model
```dart
// lib/categories/domain/category.model.dart
@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String id,
    required String name,
    required String icon,
    required String color,
    required bool isDefault,
    double? budgetLimit,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

// Predefined categories
class DefaultCategories {
  static const List<CategoryModel> categories = [
    CategoryModel(
      id: 'food',
      name: 'Food',
      icon: '🍽️',
      color: '#FF6B6B',
      isDefault: true,
    ),
    CategoryModel(
      id: 'transport',
      name: 'Transport',
      icon: '🚗',
      color: '#4ECDC4',
      isDefault: true,
    ),
    CategoryModel(
      id: 'entertainment',
      name: 'Entertainment',
      icon: '🎬',
      color: '#45B7D1',
      isDefault: true,
    ),
    CategoryModel(
      id: 'shopping',
      name: 'Shopping',
      icon: '🛍️',
      color: '#F39C12',
      isDefault: true,
    ),
    CategoryModel(
      id: 'healthcare',
      name: 'Healthcare',
      icon: '🏥',
      color: '#E74C3C',
      isDefault: true,
    ),
  ];
}
```

#### Database Schema
```dart
// Add to lib/core/data/drift.database.dart
class CategoriesTable extends Table {
  TextColumn get id => text().unique()();
  TextColumn get name => text()();
  TextColumn get icon => text()();
  TextColumn get color => text()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  RealColumn get budgetLimit => real().nullable()();
}
```

#### UI Implementation
```dart
// lib/categories/presentation/categories_screen.dart
class CategoriesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddCategoryDialog(context, ref),
          ),
        ],
      ),
      body: categories.when(
        data: (categories) => ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryTile(category: category);
          },
        ),
        loading: () => CircularProgressIndicator(),
        error: (error, stack) => ErrorWidget(error),
      ),
    );
  }
}
```

**Progress**: ⬜ Not Started

---

### 4. Analytics and Reporting

**Timeline**: 3-4 weeks
**Priority**: 🟢 LOW

#### Features
- [ ] Expense charts (pie, bar, line)
- [ ] Monthly/yearly reports
- [ ] Category breakdowns
- [ ] Spending trends analysis

#### Dependencies
```yaml
# Add to pubspec.yaml
dependencies:
  fl_chart: ^0.68.0
```

#### Implementation
```dart
// lib/analytics/presentation/analytics_screen.dart
class AnalyticsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Summary cards
            Row(
              children: [
                Expanded(child: TotalSpentCard()),
                SizedBox(width: 16),
                Expanded(child: AverageSpentCard()),
              ],
            ),
            SizedBox(height: 24),

            // Category breakdown pie chart
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Spending by Category',
                         style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: CategoryBreakdownChart(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Spending trends line chart
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Spending Trends',
                         style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: SpendingTrendsChart(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// lib/analytics/presentation/widgets/category_breakdown_chart.dart
class CategoryBreakdownChart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.watch(categoryAnalyticsProvider);

    return analytics.when(
      data: (data) => PieChart(
        PieChartData(
          sections: data.entries.map((entry) => PieChartSectionData(
            color: Color(int.parse(entry.key.color.replaceFirst('#', '0xFF'))),
            value: entry.value,
            title: '${(entry.value / data.values.reduce((a, b) => a + b) * 100).toStringAsFixed(1)}%',
            radius: 80,
          )).toList(),
        ),
      ),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => ErrorWidget(error),
    );
  }
}
```

**Progress**: ⬜ Not Started

---

### 5. Internationalization

**Timeline**: 1 week
**Priority**: 🟢 LOW

#### Setup
```yaml
# Add to pubspec.yaml
dependencies:
  flutter_localizations:
    sdk: flutter

flutter:
  generate: true
```

```yaml
# Create l10n.yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

#### ARB Files
```json
// lib/l10n/app_en.arb
{
  "@@locale": "en",
  "accountsTitle": "Accounts",
  "@accountsTitle": {
    "description": "Title for the accounts screen"
  },
  "noAccountsMessage": "No accounts created yet",
  "@noAccountsMessage": {
    "description": "Message shown when no accounts exist"
  },
  "createAccountButton": "Create Account",
  "expensesTitle": "Expenses",
  "addExpenseButton": "Add Expense",
  "categoryLabel": "Category",
  "amountLabel": "Amount",
  "dateLabel": "Date"
}
```

```json
// lib/l10n/app_es.arb
{
  "@@locale": "es",
  "accountsTitle": "Cuentas",
  "noAccountsMessage": "Aún no se han creado cuentas",
  "createAccountButton": "Crear Cuenta",
  "expensesTitle": "Gastos",
  "addExpenseButton": "Agregar Gasto",
  "categoryLabel": "Categoría",
  "amountLabel": "Cantidad",
  "dateLabel": "Fecha"
}
```

#### Implementation
```dart
// Update lib/core/presentation/app/app.dart
class MyXpensesApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initializationProvider, (_, __) {});

    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'myXpenses',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      routerConfig: router.routerConfig,

      // Add localization support
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

// Usage in widgets
Text(AppLocalizations.of(context)!.accountsTitle)
```

**Progress**: ⬜ Not Started

---

### 6. Theming and UI Enhancements

**Timeline**: 2 weeks
**Priority**: 🟢 LOW

#### Features
- [ ] Dark/light theme toggle
- [ ] Custom color schemes
- [ ] Improved animations
- [ ] Better responsive design

#### Implementation
```dart
// lib/core/theme/theme_notifier.dart
@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() {
    // Load from preferences
    return ThemeMode.system;
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    // Save to preferences
  }
}

// lib/core/theme/app_theme.dart
class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.teal,
      brightness: Brightness.light,

      // Custom component themes
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.teal,
      brightness: Brightness.dark,

      // Custom component themes for dark mode
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

// Update MyXpensesApp
class MyXpensesApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'myXpenses',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: router.routerConfig,
    );
  }
}
```

#### Settings Screen
```dart
// lib/settings/presentation/settings_screen.dart
class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.palette),
            title: Text('Theme'),
            subtitle: Text(_getThemeModeText(themeMode)),
            onTap: () => _showThemeDialog(context, ref),
          ),

          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            subtitle: Text('English'),
            onTap: () => _showLanguageDialog(context, ref),
          ),
        ],
      ),
    );
  }
}
```

**Progress**: ⬜ Not Started

---

## 📅 Implementation Timeline

### Phase 1 (Weeks 1-6): Core Features
1. Week 1-2: Search and filtering system
2. Week 3-4: Data export functionality
3. Week 5-6: Category management system

### Phase 2 (Weeks 7-12): Advanced Features
1. Week 7-10: Analytics and reporting
2. Week 11: Internationalization
3. Week 12: Theming and UI enhancements

---

## 🎯 Success Metrics

### Feature Adoption
- [ ] Search functionality used by 70%+ of users
- [ ] Export feature used monthly by 50%+ of users
- [ ] Custom categories created by 60%+ of users

### User Experience
- [ ] Feature discovery rate > 80%
- [ ] User satisfaction score > 4.5/5
- [ ] Feature usage retention > 60%

---

## 📝 Progress Tracking

### Completed Features
*Track completed new features here*

### In Progress
*Track current feature development here*

### Blocked Items
*Track any feature blockers here*

---

## 🤝 Contributing Guidelines

When implementing new features:

1. **Start with user research** - Validate feature need
2. **Design before coding** - Create mockups and user flows
3. **Implement incrementally** - Break features into smaller parts
4. **Test thoroughly** - Include unit, widget, and integration tests
5. **Document everything** - Update docs and add inline comments
6. **Consider accessibility** - Ensure features work for all users

---

*This roadmap should be updated as user feedback is gathered and priorities shift.*
