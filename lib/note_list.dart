import 'package:flutter/material.dart';
import 'note_form.dart';
import 'note_card.dart';

class NoteListScreen extends StatefulWidget {
  final List<Map<String, String>> notes;

  const NoteListScreen({required this.notes, Key? key}) : super(key: key);

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Map<String, String>> notes = [];

  @override
  void initState() {
    super.initState();
    notes = widget.notes;
  }

  void _addNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NoteFormWidget(
          onSave: (title, body) {
            setState(() {
              notes.add({'title': title, 'body': body});
            });
          },
        ),
      ),
    );
  }

  void _editNote(int index) {
    final note = notes[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NoteFormWidget(
          initialTitle: note['title'],
          initialBody: note['body'],
          onSave: (title, body) {
            setState(() {
              notes[index] = {'title': title, 'body': body};
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: notes.isEmpty
          ? Center(child: Text('No notes yet'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteCard(
                  title: note['title']!,
                  body: note['body']!,
                  date: DateTime.now(),
                  onDelete: () {
                    setState(() {
                      notes.removeAt(index);
                    });
                  },
                  onEdit: () => _editNote(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: Icon(Icons.add),
      ),
    );
  }
}
