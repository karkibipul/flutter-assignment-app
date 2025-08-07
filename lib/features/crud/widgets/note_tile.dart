import 'package:flutter/material.dart';
import '../model/note_model.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const NoteTile({
    Key? key,
    required this.note,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.title),
      subtitle: Text(note.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: Icon(Icons.edit), onPressed: onEdit),
          IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
        ],
      ),
    );
  }
}
