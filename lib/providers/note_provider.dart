import 'package:flutter/material.dart';

import '../models/note.dart';
import '../utils/database_helper.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> addNote(Note note) async {
    await DatabaseHelper().insertNote(note);
    _notes.add(note);
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await DatabaseHelper().deleteNote(id);
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  Future<void> updateNote(Note updatedNote) async {
    await DatabaseHelper().updateNote(updatedNote);
    final index = _notes.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      _notes[index] = updatedNote;
    }
    notifyListeners();
  }

  Future<void> loadNotes() async {
    _notes = await DatabaseHelper().getNotes();
    notifyListeners();
  }
}
