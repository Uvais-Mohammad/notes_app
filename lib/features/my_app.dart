import 'package:flutter/material.dart';
import 'package:notes_app/features/notes/screens/notes_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotesScreen(),
    );
  }
}
