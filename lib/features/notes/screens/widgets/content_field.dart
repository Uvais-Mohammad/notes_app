import 'package:flutter/material.dart';

class ContentField extends StatelessWidget {
  const ContentField({
    super.key,
    required TextEditingController contentController,
  }) : _contentController = contentController;

  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _contentController,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Content',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a content';
            }
            return null;
          },
        ),
        const Divider(),
      ],
    );
  }
}