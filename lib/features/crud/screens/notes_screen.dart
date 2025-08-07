import 'package:flutter/material.dart';
import '../model/note_model.dart';
import '../services/note_service.dart';
import '../widgets/note_tile.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final NoteService _noteService = NoteService();

  void _openNoteDialog({Note? note}) {
  final titleController = TextEditingController(text: note?.title ?? '');
  final descController = TextEditingController(text: note?.description ?? '');

  showDialog(
    context: context,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(24), 
      child: Container(
        width: 500, 
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              note == null ? 'Add Note' : 'Edit Note',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final newNote = Note(
                  id: note?.id ?? '',
                  title: titleController.text.trim(),
                  description: descController.text.trim(),
                );

                if (note == null) {
                  await _noteService.addNote(newNote);
                } else {
                  await _noteService.updateNote(newNote);
                }

                Navigator.of(context).pop(); // ✅ Auto-close
              },
              child: Text(note == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: StreamBuilder<List<Note>>(
        stream: _noteService.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return NoteTile(
                note: note,
                onEdit: () => _openNoteDialog(note: note),
                onDelete: () => _noteService.deleteNote(note.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openNoteDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
