import 'package:flutter/material.dart';

class MyTheme{
  static final lightTheme = ThemeData(
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
      );
}