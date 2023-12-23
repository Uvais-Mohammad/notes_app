
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/features/notes/index.dart';

final selectNoteProvider = StateNotifierProvider<SelectNoteProvider, Note?>((ref) 
  => SelectNoteProvider());

class SelectNoteProvider extends StateNotifier<Note?> {
  SelectNoteProvider() : super(null);

  void select(Note note) {
    state = note;
  }

  void unselect() {
    state = null;
  }
}