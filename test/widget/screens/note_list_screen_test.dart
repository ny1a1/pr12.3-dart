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
}
