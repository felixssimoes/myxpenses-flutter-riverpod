import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myxpenses/accounts/presentation/list/widgets/accounts_list_tile.dart';

import '../../../../_helpers/mocks.dart';

void main() {
  testWidgets('AccountListTile shows account info', (tester) async {
    final account = mockAccountModel();
    final tapCallback = MockVoidCallback();
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AccountListTile(
            account: account,
            total: 123,
            onTap: () => tapCallback(),
          ),
        ),
      ),
    );
    await tester.pump();

    final nameFinder = find.text(account.name);
    expect(nameFinder, findsOneWidget);
    expect(find.text('123.00'), findsOneWidget);
    verifyZeroInteractions(tapCallback);

    await tester.tap(nameFinder);
    verify(tapCallback());
    verifyNoMoreInteractions(tapCallback);
  });
}
