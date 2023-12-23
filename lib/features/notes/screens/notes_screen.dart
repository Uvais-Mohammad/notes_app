import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/features/notes/logic/notes_provider.dart';
import 'package:notes_app/features/notes/logic/select_note_provider.dart';
import 'package:notes_app/features/notes/models/note_model.dart';
import 'package:notes_app/features/notes/repository/notes_repository.dart';
import 'package:notes_app/features/notes/screens/widgets/add_note_sheet.dart';
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
      appBar: AppBar(
        title: ref.watch(selectNoteProvider) == null
            ? const Text('📝 Notes')
            : AnimatedScale(
                scale: ref.watch(selectNoteProvider) == null ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                child: IconButton(
                  onPressed: () {
                    ref.read(selectNoteProvider.notifier).unselect();
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
              ),
        actions: [
          AnimatedScale(
            scale: ref.watch(selectNoteProvider) == null ? 0 : 1,
            duration: const Duration(milliseconds: 200),
            child: IconButton(
              onPressed: () {
                ref
                    .read(notesProvider.notifier)
                    .delete(ref.read(selectNoteProvider)!);
                ref.read(selectNoteProvider.notifier).unselect();
              },
              icon: const Icon(
                Icons.delete_outline_outlined,
                size: 30,
              ),
            ),
          ),
          AnimatedScale(
            scale: ref.watch(selectNoteProvider) == null ? 0 : 1,
            duration: const Duration(milliseconds: 200),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                size: 30,
              ),
            ),
          ),
        ],
      ),
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
              return Dismissible(
                key: Key(note.id.toString()),
                onDismissed: (direction) async {
                  await ref.read(notesProvider.notifier).delete(note);
                },
                background: Container(
                  color: Colors.white,
                  child: const Icon(Icons.delete),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ListTile(
                      onLongPress: () {
                        ref.read(selectNoteProvider.notifier).select(note);
                      },
                      title: Text(
                        note.title,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      tileColor: note.color,
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.content,
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            DateFormat.yMd().format(note.updatedAt),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    if (ref.watch(selectNoteProvider) == note)
                      Positioned.fill(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              );
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
              builder: (_) => const AddNoteSheet(),
              isScrollControlled: true,
            );
          },
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
