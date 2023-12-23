import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/features/notes/logic/add_note_color_provider.dart';

class ColorTile extends ConsumerWidget {
  final Color color;

  const ColorTile({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color selectedColor = ref.watch(addNoteColorProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          ref.read(addNoteColorProvider.notifier).changeColor(color);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: color,
              ),
              width: 50,
              height: 50,
            ),
            if (selectedColor.value == color.value)
              const Positioned(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
