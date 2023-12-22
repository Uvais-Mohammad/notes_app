import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/features/notes/models/note_model.dart';
import 'package:notes_app/features/notes/repository/i_notes_repository.dart';
import 'package:notes_app/shared/services/firestore_service/firestore_service.dart';
import 'package:notes_app/shared/services/firestore_service/i_firestore_service.dart';
import 'package:notes_app/shared/services/sqflite_service/i_sqflite_service.dart';
import 'package:notes_app/shared/services/sqflite_service/sqflite_service.dart';

final notesRepositoryProvider =
    Provider<INotesRepository>((ref) => NotesRepository(
          sqfliteService: ref.read(sqfliteServiceProvider),
          firebaseService: ref.watch(firestoreServiceProvider),
        ));

final class NotesRepository implements INotesRepository {
  final ISqfliteService _sqfliteService;
  final IFirestoreService _firebaseService;

  final String _table = 'notes';
  NotesRepository({
    required ISqfliteService sqfliteService,
    required IFirestoreService firebaseService,
  })  : _sqfliteService = sqfliteService,
        _firebaseService = firebaseService;

  @override
  Future<(bool, int)> createNoteOffline(Note note) async {
    final Map<String, dynamic> data = note.toJson();
    final (bool, int) result =
        await _sqfliteService.insert(table: _table, data: data);
    return result;
  }

  @override
  Future<bool> createNoteOnline(Note note) async {
    final Map<String, dynamic> data = note.toJson();
    await _firebaseService.addDocument(path: _table, data: data);
    return true;
  }

  @override
  Future<bool> deleteNoteOffline(int id) async {
    final bool result = await _sqfliteService
        .delete(table: _table, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  @override
  Future<bool> deleteNoteOnline(int id) async {
    await _firebaseService.deleteDocument(path: _table, id: id.toString());
    return true;
  }

  @override
  Future<Note> getNoteByIdOffline(int id) async {
    final List<Map<String, dynamic>> result = await _sqfliteService
        .query(table: _table, where: 'id = ?', whereArgs: [id]);
    final Note note = Note.fromJson(result.first);
    return note;
  }

  @override
  Future<List<Note>> getNotesOffline() async {
    final List<Map<String, dynamic>> result =
        await _sqfliteService.query(table: _table, where: '1', whereArgs: []);
    final List<Note> notes = result.map((e) => Note.fromJson(e)).toList();
    return notes.where((element) => !element.isTrashed).toList();
  }

  @override
  Future<bool> updateNoteOffline(Note note) async {
    final Map<String, dynamic> data = note.toJson();
    final bool result = await _sqfliteService.update(
        table: _table, data: data, where: 'id = ?', whereArgs: [note.id]);
    return result;
  }

  @override
  Future<bool> updateNoteOnline(Note note) async {
    final Map<String, dynamic> data = note.toJson();
    await _firebaseService.updateDocument(path: _table, data: data);
    return true;
  }

  @override
  Future<bool> syncNotes() async {
    final List<int> unsyncedNotes = await _getUnsyncedNotes();
    if (unsyncedNotes.isEmpty) {
      return true;
    }
    final List<Note> notes = await Future.wait(
        unsyncedNotes.map((e) => getNoteByIdOffline(e)).toList());
    if (notes.any((element) => element.isTrashed)) {
      await Future.wait(notes
          .where((element) => element.isTrashed)
          .map((e) => deleteNoteOnline(e.id!))
          .toList());
      await _sqfliteService
          .delete(table: _table, where: 'isTrashed = ?', whereArgs: [1]);
    }
    await Future.wait(notes
        .map((e) => createNoteOnline(e.copyWith(isSynced: true)))
        .toList());
    await _sqfliteService.update(
      table: _table,
      data: {'isSynced': 1},
      where: 'id IN (${unsyncedNotes.join(',')})',
      whereArgs: [],
    );
    debugPrint('Synced Notes: $notes');
    return true;
  }

  Future<List<int>> _getUnsyncedNotes() async {
    final List<Map<String, dynamic>> result = await _sqfliteService
        .query(table: _table, where: 'isSynced = ?', whereArgs: [0]);
    final List<int> ids = result.map((e) => e['id'] as int).toList();
    debugPrint('Unsynced Ids: $ids');
    return ids;
  }
}
