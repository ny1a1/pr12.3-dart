import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pr12_3/note_list.dart';

void main() {
  testWidgets('Shows EmptyState when no notes', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: NoteListScreen(notes: [])));
    expect(find.text('No notes yet'), findsOneWidget);
  });

  testWidgets('Shows list of notes when data exists', (
    WidgetTester tester,
  ) async {
    final notes = [
      {'title': 'Note 1', 'body': 'Body text'},
      {'title': 'Note 2', 'body': 'Another body'},
    ];
    await tester.pumpWidget(MaterialApp(home: NoteListScreen(notes: notes)));

    expect(find.byType(ListTile), findsNWidgets(2));
  });

  testWidgets('FAB button is present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: NoteListScreen(notes: [])));
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Add note via FAB', (tester) async {
    await tester.pumpWidget(MaterialApp(home: NoteListScreen(notes: [])));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('titleField')), 'New Note');
    await tester.enterText(
      find.byKey(Key('bodyField')),
      'This is valid body text',
    );
    await tester.tap(find.byKey(Key('saveButton')));
    await tester.pumpAndSettle();

    expect(find.text('New Note'), findsOneWidget);
  });

  testWidgets('Edit existing note', (tester) async {
    final notes = [
      {'title': 'Old Title', 'body': 'Old body text'},
    ];
    await tester.pumpWidget(MaterialApp(home: NoteListScreen(notes: notes)));

    await tester.longPress(find.text('Old Title'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('titleField')),
      'Updated Title',
    );
    await tester.enterText(
      find.byKey(const Key('bodyField')),
      'Updated body text',
    );
    await tester.tap(find.byKey(const Key('saveButton')));
    await tester.pumpAndSettle();

    expect(find.text('Updated Title'), findsOneWidget);
  });

  testWidgets('Delete existing note', (tester) async {
    final notes = [
      {'title': 'Note to delete', 'body': 'Some body'},
    ];
    await tester.pumpWidget(MaterialApp(home: NoteListScreen(notes: notes)));

    await tester.longPress(find.text('Note to delete'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Note to delete'), findsNothing);
  });
}
