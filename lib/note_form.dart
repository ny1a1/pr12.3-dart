import 'package:flutter/material.dart';

class NoteFormWidget extends StatefulWidget {
  final String? initialTitle;
  final String? initialBody;
  final Function(String title, String body)? onSave;

  const NoteFormWidget({
    super.key,
    this.initialTitle,
    this.initialBody,
    this.onSave,
  });

  @override
  State<NoteFormWidget> createState() => _NoteFormWidgetState();
}

class _NoteFormWidgetState extends State<NoteFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? '';
    _bodyController.text = widget.initialBody ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                key: Key('titleField'),
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Title is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                key: Key('bodyField'),
                controller: _bodyController,
                decoration: InputDecoration(labelText: 'Body'),
                validator: (value) => value != null && value.length < 10
                    ? 'Body must be at least 10 characters'
                    : null,
                onChanged: (_) => setState(() {}),
                maxLines: 5,
              ),
              SizedBox(height: 8),
              Text('${_bodyController.text.length} characters'),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  key: const Key('saveButton'),
                  onPressed:
                      (_titleController.text.isNotEmpty &&
                          _bodyController.text.length >= 10)
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            widget.onSave?.call(
                              _titleController.text,
                              _bodyController.text,
                            );
                            Navigator.pop(context);
                          }
                        }
                      : null,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
