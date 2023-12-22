import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/shared/services/sqflite_service/i_sqflite_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final sqfliteServiceProvider =
    Provider<ISqfliteService>((ref) => throw UnimplementedError());

final class SqfliteService implements ISqfliteService {
  final Database _database;

  SqfliteService({
    required Database database,
  }) : _database = database;

  static Future<Database> init() async {
    final databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'notes.db');
    final Database database = await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, content TEXT, color INTEGER, createdAt INTEGER, updatedAt INTEGER, isSynced INTEGER DEFAULT 0, isTrashed INTEGER DEFAULT 0)',
        );
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion == 1 && newVersion == 2) {
          await db.execute(
            'ALTER TABLE notes ADD COLUMN isSynced INTEGER DEFAULT 0',
          );
        }
      },
    );
    return database;
  }

  @override
  Future<(bool, int)> insert(
      {required String table, required Map<String, dynamic> data}) async {
    final int result = await _database.insert(table, data);
    return (result > 0, result);
  }

  @override
  Future<bool> update(
      {required String table,
      required Map<String, dynamic> data,
      required String where,
      required List<dynamic> whereArgs}) async {
    final int result = await _database
        .update(table, data, where: where, whereArgs: whereArgs);
    return result > 0;
  }

  @override
  Future<bool> delete(
      {required String table,
      required String where,
      required List<dynamic> whereArgs}) async {
    final int result =
        await _database.delete(table, where: where, whereArgs: whereArgs);
    return result > 0;
  }

  @override
  Future<List<Map<String, dynamic>>> query(
      {required String table,
      required String where,
      required List<dynamic> whereArgs}) async {
    final List<Map<String, dynamic>> result =
        await _database.query(table, where: where, whereArgs: whereArgs);
    return result;
  }
}
