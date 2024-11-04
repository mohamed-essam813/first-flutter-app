import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // INITIALIZATION
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  // list of notes
  final List<Note> currentNotes = [];

  // CREATE
  Future<void> addNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;

    await isar.writeTxn(() => isar.notes.put(newNote));

    fetchNotes();
  }

  // READ
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  // UPDATE
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);

    if (existingNote != null) {
      existingNote.text = newText;

      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // DELETE
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
