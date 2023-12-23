import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/features/notes/index.dart';

class NoteSheet extends ConsumerStatefulWidget {
  final Note? note;
  const NoteSheet({super.key, this.note});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddNoteSheetState();
}

class _AddNoteSheetState extends ConsumerState<NoteSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

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
            NoteHeader(
              title: widget.note == null ? 'Add Note' : 'Edit Note',
            ),
            TitleField(titleController: _titleController),
            ContentField(contentController: _contentController),
            const ColorPicker(),
            FormButtons(
              formKey: _formKey,
              titleController: _titleController,
              contentController: _contentController,
              note: widget.note,
            ),
          ],
        ),
      ),
    );
  }
}
