import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/features/notes/index.dart';

class FormButtons extends ConsumerWidget {
  const FormButtons({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    required TextEditingController contentController,
  })  : _formKey = formKey,
        _titleController = titleController,
        _contentController = contentController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _titleController;
  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              if (_formKey.currentState!.validate()) {
                ref.read(notesProvider.notifier).create(
                      Note(
                        title: _titleController.text,
                        content: _contentController.text,
                        color: ref.read(addNoteColorProvider),
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                    );
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
