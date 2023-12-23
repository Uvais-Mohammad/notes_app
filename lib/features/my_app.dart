import 'package:flutter/material.dart';
import 'package:notes_app/features/notes/screens/notes_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NotesScreen(),
      theme: ThemeData(
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 28,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
        listTileTheme: const ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
