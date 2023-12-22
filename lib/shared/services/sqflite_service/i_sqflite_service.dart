abstract class ISqfliteService {
  Future<(bool, int)> insert({required String table, required Map<String, dynamic> data});
  Future<bool> update({required String table, required Map<String, dynamic> data, required String where, required List<dynamic> whereArgs});
  Future<bool> delete({required String table, required String where, required List<dynamic> whereArgs});
  Future<List<Map<String, dynamic>>> query({required String table, required String where, required List<dynamic> whereArgs});
}
