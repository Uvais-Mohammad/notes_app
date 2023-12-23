import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:notes_app/features/notes/index.dart';
import 'package:notes_app/features/notes/screens/widgets/todo_card.dart';
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
      appBar: const CustomAppBar(),
      body: notes.when(
        data: (notes) {
          if (notes.isEmpty) {
            return const Center(child: Text('No notes found'));
          }
          return MasonryGridView.builder(
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: notes.length,
            padding: const EdgeInsets.all(4),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final Note note = notes[index];
              return TodoCard(note: note);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () async {
            showModalBottomSheet(
              context: context,
              builder: (_) => const NoteSheet(),
              isScrollControlled: true,
            );
          },
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
