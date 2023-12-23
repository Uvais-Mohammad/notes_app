import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/features/notes/index.dart';

class TodoCard extends ConsumerWidget {
  const TodoCard({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.black.withOpacity(0.5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListTile(
            onLongPress: () {
              ref.read(selectNoteProvider.notifier).select(note);
            },
            onTap: () {
              ref
                  .read(addNoteColorProvider.notifier)
                  .changeColor(note.color);
              showModalBottomSheet(
                context: context,
                builder: (_) => NoteSheet(note: note),
                isScrollControlled: true,
              );
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
  }
}