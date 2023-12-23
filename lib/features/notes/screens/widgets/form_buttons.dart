import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/features/notes/index.dart';

class FormButtons extends ConsumerWidget {
  const FormButtons({
    Key? key,
    required this.formKey,
    required this.titleController,
    required this.contentController,
    required this.note,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final Note? note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isEditing = note != null;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (isEditing) {
                  ref.read(notesProvider.notifier).updateNote(
                        note!.copyWith(
                          title: titleController.text,
                          content: contentController.text,
                          color: ref.read(addNoteColorProvider),
                          updatedAt: DateTime.now(),
                        ),
                      );
                } else {
                  ref.read(notesProvider.notifier).create(
                        Note(
                          title: titleController.text,
                          content: contentController.text,
                          color: ref.read(addNoteColorProvider),
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ),
                      );
                }
                Navigator.pop(context);
              }
            },
            child: Text(isEditing ? 'Update' : 'Save'),
          ),
        ],
      ),
    );
  }
}
