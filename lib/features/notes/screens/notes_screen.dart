import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:notes_app/features/notes/logic/notes_provider.dart';
import 'package:notes_app/features/notes/models/note_model.dart';
import 'package:notes_app/features/notes/repository/notes_repository.dart';
import 'package:notes_app/shared/services/connection_service/connection_service.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(connectionServiceProvider).onStatusChange.listen((event) {
      if (event == InternetStatus.connected) {
        ref.read(notesRepositoryProvider).syncNotes();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<Note>> notes = ref.watch(notesProvider);
    return Scaffold(
      body: notes.when(
        data: (notes) {
          if (notes.isEmpty) {
            return const Center(child: Text('No notes found'));
          }
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final Note note = notes[index];
              return Dismissible(
                key: Key(note.id.toString()),
                onDismissed: (direction) async {
                  await ref.read(notesProvider.notifier).delete(note);
                },
                background: Container(
                  color: Colors.white,
                  child: const Icon(Icons.delete),
                ),
                child: ListTile(
                  title: Text(note.title),
                  tileColor: note.color,
                  subtitle: Text(note.content),
                  trailing: IconButton(
                    onPressed: () async {
                      await ref
                          .read(notesProvider.notifier)
                          .updateNote(note.copyWith(title: 'Title3'));
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref.read(notesProvider.notifier).create(
                Note(
                  title: 'Title2',
                  content: 'Content2',
                  color: Colors.green,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
