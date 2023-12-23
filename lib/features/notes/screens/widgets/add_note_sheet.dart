import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/features/notes/index.dart';

class AddNoteSheet extends ConsumerStatefulWidget {
  const AddNoteSheet({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddNoteSheetState();
}

class _AddNoteSheetState extends ConsumerState<AddNoteSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: ListView(
          children: [
            const AddNoteHeader(),
            TitleField(titleController: _titleController),
            ContentField(contentController: _contentController),
            const ColorPicker(),
            FormButtons(
              formKey: _formKey,
              titleController: _titleController,
              contentController: _contentController,
            ),
          ],
        ),
      ),
    );
  }
}
