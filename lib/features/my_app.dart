import 'package:flutter/material.dart';
import 'package:notes_app/features/notes/screens/notes_screen.dart';
import 'package:notes_app/shared/themes/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NotesScreen(),
      theme: MyTheme.lightTheme,
    );
  }
}
