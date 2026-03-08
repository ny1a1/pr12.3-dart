import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pr12_3/note_form.dart';

void main() {
  group('NoteFormWidget', () {
    testWidgets('Title field is required', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: NoteFormWidget()));

      await tester.enterText(find.byKey(Key('bodyField')), 'Valid body text');
      await tester.tap(find.byKey(Key('saveButton')));

      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Title is required'), findsOneWidget);
    });

    testWidgets('Body must be at least 10 chars', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: NoteFormWidget()));

      await tester.enterText(find.byKey(Key('titleField')), 'My Note');
      await tester.enterText(find.byKey(Key('bodyField')), 'short');
      await tester.tap(find.byKey(Key('saveButton')));

      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Body must be at least 10 characters'), findsOneWidget);
    });

    testWidgets('Save button enabled only with valid data', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: NoteFormWidget()));

      final ElevatedButton initialButton = tester.widget(
        find.byKey(Key('saveButton')),
      );
      expect(initialButton.onPressed, isNull);

      await tester.enterText(find.byKey(Key('titleField')), 'My Note');
      await tester.enterText(
        find.byKey(Key('bodyField')),
        'This is valid body text',
      );
      await tester.pump();

      final ElevatedButton validButton = tester.widget(
        find.byKey(Key('saveButton')),
      );
      expect(validButton.onPressed, isNotNull);
    });

    testWidgets('Character counter updates', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: NoteFormWidget()));

      await tester.enterText(find.byKey(Key('bodyField')), '12345');
      await tester.pump();

      expect(find.text('5 characters'), findsOneWidget);
    });
  });
}
