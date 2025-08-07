import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/note_model.dart';

class NoteService {
  final _notesCollection = FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(Note note) async {
    await _notesCollection.add(note.toMap());
  }

  Stream<List<Note>> getNotes() {
    return _notesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Note.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Future<void> updateNote(Note note) async {
    await _notesCollection.doc(note.id).update(note.toMap());
  }

  Future<void> deleteNote(String id) async {
    await _notesCollection.doc(id).delete();
  }
}
