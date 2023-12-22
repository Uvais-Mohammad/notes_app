import 'package:notes_app/features/notes/models/note_model.dart';

abstract interface class INotesRepository {
  Future<List<Note>> getNotesOffline();
  Future<Note> getNoteByIdOffline(int id);
  Future<(bool,int)> createNoteOffline(Note note);
  Future<bool> createNoteOnline(Note note);
  Future<bool> updateNoteOffline(Note note);
  Future<bool> updateNoteOnline(Note note);
  Future<bool> deleteNoteOffline(int id);
  Future<bool> deleteNoteOnline(int id);
  Future<bool> syncNotes();
}