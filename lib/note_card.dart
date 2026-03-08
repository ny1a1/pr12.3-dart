import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String body;
  final DateTime date;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const NoteCard({
    required this.title,
    required this.body,
    required this.date,
    this.onDelete,
    this.onEdit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(title),
        subtitle: Text(body.length > 50 ? body.substring(0, 50) : body),
        trailing: Text('${date.day}.${date.month}.${date.year}'),
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            builder: (_) => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit, color: Colors.blue),
                    title: const Text('Edit'),
                    onTap: () {
                      Navigator.pop(context);
                      onEdit?.call();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: const Text('Delete'),
                    onTap: () {
                      Navigator.pop(context);
                      onDelete?.call();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
