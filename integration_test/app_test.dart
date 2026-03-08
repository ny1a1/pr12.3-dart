import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pr12_3/main.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full user flow: create → edit → delete note', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('titleField')), 'Test Note');
    await tester.enterText(
      find.byKey(Key('bodyField')),
      'This is a valid body text',
    );
    await tester.tap(find.byKey(Key('saveButton')));
    await tester.pumpAndSettle();

    expect(find.text('Test Note'), findsOneWidget);

    await tester.tap(find.text('Test Note'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(Key('bodyField')),
      'Edited body text here',
    );
    await tester.tap(find.byKey(Key('saveButton')));
    await tester.pumpAndSettle();

    expect(find.text('Edited body text here'), findsOneWidget);

    await tester.longPress(find.text('Test Note'));
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('No notes yet'), findsOneWidget);
  });
}
