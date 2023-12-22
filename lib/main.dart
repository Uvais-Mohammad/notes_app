import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/features/my_app.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:notes_app/shared/services/sqflite_service/sqflite_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      overrides: [
        sqfliteServiceProvider.overrideWithValue(SqfliteService(database: await SqfliteService.init())),
      ],
      child: const MyApp(),
    ),
  );
}
