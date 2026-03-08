import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pr12_3/note_card.dart';


void main() {
  testWidgets('Displays title and preview', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: NoteCard(title: 'My Note', body: 'This is a long body text', date: DateTime.now()),
    ));

    expect(find.text('My Note'), findsOneWidget);
    expect(find.textContaining('This is a long'), findsOneWidget);
  });

  testWidgets('Long press shows options', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: NoteCard(title: 'Note', body: 'Body text', date: DateTime.now()),
    ));

    await tester.longPress(find.text('Note'));
    await tester.pump();

    expect(find.text('Edit'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
  });
}