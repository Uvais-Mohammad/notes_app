import 'package:flutter/material.dart';
import 'package:notes_app/features/notes/index.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            ColorTile(color: Colors.red),
            ColorTile(color: Colors.blue),
            ColorTile(color: Colors.green),
            ColorTile(color: Colors.purple),
            ColorTile(color: Colors.orange),
            ColorTile(color: Colors.pink),
            ColorTile(color: Colors.teal),
            ColorTile(color: Colors.brown),
            ColorTile(color: Colors.grey),
          ],
        ),
      ),
    );
  }
}