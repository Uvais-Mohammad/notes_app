import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/features/notes/index.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
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
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
