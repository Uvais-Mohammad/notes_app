import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/features/notes/models/note_model.dart';
import 'package:notes_app/features/notes/repository/notes_repository.dart';
import 'package:notes_app/shared/services/connection_service/connection_service.dart';

final notesProvider =
    AutoDisposeAsyncNotifierProvider<NotesProvider, List<Note>>(
        () => NotesProvider());

class NotesProvider extends AutoDisposeAsyncNotifier<List<Note>> {
  @override
  FutureOr<List<Note>> build() async {
    List<Note> notes =
        await ref.read(notesRepositoryProvider).getNotesOffline();
    return notes;
  }

  Future<void> _refresh() async {
    state = await AsyncValue.guard(
        () => ref.read(notesRepositoryProvider).getNotesOffline());
  }

  Future<void> create(Note note) async {
    bool isConnected = await ref.read(connectionServiceProvider).isConnected;
    if (isConnected) {
      final result = await ref.read(notesRepositoryProvider).createNoteOffline(
            note.copyWith(
              isSynced: true,
            ),
          );
      final isCreated = result.$1;
      final id = result.$2;
      if (isCreated) {
        _refresh();
        await ref.read(notesRepositoryProvider).createNoteOnline(
              note.copyWith(
                id: id,
                isSynced: true,
              ),
            );
      }
    } else {
      await ref.read(notesRepositoryProvider).createNoteOffline(note);
      _refresh();
    }
  }

  Future<void> updateNote(Note note) async {
    bool isConnected = await ref.read(connectionServiceProvider).isConnected;
    if (isConnected) {
      final isUpdated =
          await ref.read(notesRepositoryProvider).updateNoteOffline(
                note.copyWith(
                  isSynced: true,
                ),
              );
      if (isUpdated) {
        _refresh();
        await ref.read(notesRepositoryProvider).updateNoteOnline(
              note.copyWith(
                isSynced: true,
              ),
            );
      }
    } else {
      await ref.read(notesRepositoryProvider).updateNoteOffline(note.copyWith(
            isSynced: false,
          ));
      _refresh();
    }
  }

  Future<void> delete(Note note) async {
    bool isConnected = await ref.read(connectionServiceProvider).isConnected;
    if (isConnected) {
      final isDeleted =
          await ref.read(notesRepositoryProvider).deleteNoteOffline(note.id!);
      if (isDeleted) {
        _refresh();
        await ref.read(notesRepositoryProvider).deleteNoteOnline(note.id!);
      }
    } else {
      await ref.read(notesRepositoryProvider).updateNoteOffline(
            note.copyWith(
              isTrashed: true,
              isSynced: false,
            ),
          );
      _refresh();
    }
  }
}
