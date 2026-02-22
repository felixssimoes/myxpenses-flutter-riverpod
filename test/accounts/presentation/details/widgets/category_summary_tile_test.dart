import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:myxpenses/accounts/presentation/details/widgets/category_summary_tile.dart';
import 'package:myxpenses/expenses/domain/category_summary.model.dart';

import '../../../../_helpers/mocks.dart';

void main() {
  late ThemeData theme;

  CategorySummary buildSummary({
    String category = 'Groceries',
    double total = 120.5,
    int expenseCount = 3,
  }) {
    return CategorySummary(
      category: category,
      total: total,
      expenseCount: expenseCount,
    );
  }

  Future<void> pumpTile(
    WidgetTester tester, {
    required CategorySummary summary,
    ThemeData? overrideTheme,
    VoidCallback? onTap,
  }) async {
    final appTheme = overrideTheme ?? theme;

    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme,
        home: Scaffold(
          body: CategorySummaryTile(
            summary: summary,
            onTap: onTap ?? () {},
          ),
        ),
      ),
    );
  }

  setUp(() {
    Intl.defaultLocale = 'en_US';
    theme = ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true);
  });

  group('CategorySummaryTile', () {
    testWidgets('Displays category name correctly', (tester) async {
      final summary = buildSummary(category: 'Groceries');

      await pumpTile(tester, summary: summary);

      expect(find.text('Groceries'), findsOneWidget);
    });

    testWidgets('Displays All categories for empty or all label', (tester) async {
      final summary = buildSummary(category: '');

      await pumpTile(tester, summary: summary);

      expect(find.text('All categories'), findsOneWidget);
    });

    testWidgets('Formats currency total correctly', (tester) async {
      final summary = buildSummary(total: 123.456, expenseCount: 1);
      final currencyFormat = NumberFormat.simpleCurrency();

      await pumpTile(tester, summary: summary);

      expect(find.text(currencyFormat.format(123.456)), findsOneWidget);
    });

    testWidgets('Shows expense count label', (tester) async {
      final summary = buildSummary(expenseCount: 5);

      await pumpTile(tester, summary: summary);

      expect(find.text('5 expenses'), findsOneWidget);
    });

    testWidgets('"All categories" uses bold title style', (tester) async {
      final summary = buildSummary(category: 'All categories');

      await pumpTile(tester, summary: summary);

      final title = tester.widget<Text>(find.text('All categories'));
      expect(title.style?.fontWeight, FontWeight.w700);
    });

    testWidgets('"All categories" uses surface variant background', (tester) async {
      final summary = buildSummary(category: 'All categories');

      await pumpTile(tester, summary: summary);

      final tile = tester.widget<ListTile>(find.byType(ListTile));
      expect(tile.tileColor, theme.colorScheme.surfaceContainerHighest);
    });

    testWidgets('Regular categories use default styling', (tester) async {
      final summary = buildSummary(category: 'Travel');

      await pumpTile(tester, summary: summary);

      final title = tester.widget<Text>(find.text('Travel'));
      expect(title.style?.fontWeight, theme.textTheme.titleMedium?.fontWeight);
      final tile = tester.widget<ListTile>(find.byType(ListTile));
      expect(tile.tileColor, isNull);
    });

    testWidgets('Shows trailing chevron icon', (tester) async {
      final summary = buildSummary(category: 'Groceries');

      await pumpTile(tester, summary: summary);

      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('Fires onTap callback when tapped', (tester) async {
      final summary = buildSummary(category: 'Groceries');
      final onTap = MockVoidCallback();

      await pumpTile(tester, summary: summary, onTap: onTap.call);
      await tester.tap(find.byType(CategorySummaryTile));
      await tester.pumpAndSettle();

      verify(onTap.call()).called(1);
    });

    testWidgets('Uses singular and plural expense labels', (tester) async {
      final singularSummary = buildSummary(expenseCount: 1);
      final pluralSummary = buildSummary(expenseCount: 2, category: 'Travel');

      await pumpTile(tester, summary: singularSummary);
      expect(find.text('1 expense'), findsOneWidget);

      await pumpTile(tester, summary: pluralSummary);
      expect(find.text('2 expenses'), findsOneWidget);
    });
  });
}
