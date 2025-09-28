import 'package:flutter/foundation.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/services/database_helper.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    _notes = await _dbHelper.getNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _dbHelper.insertNote(note);
    await loadNotes();
  }

  Future<void> updateNote(Note note) async {
    await _dbHelper.updateNote(note);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await _dbHelper.deleteNote(id);
    await loadNotes();
  }
}