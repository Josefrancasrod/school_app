import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'school.db'),
      onCreate: (db, version) => _createDb(db),
      version: 1,
    );
  }

   static void _createDb(sql.Database db){

    db.execute(
            'CREATE TABLE classes (id TEXT PRIMARY KEY, title TEXT, teacher TEXT, color INTEGER)');
    db.execute(
            'CREATE TABLE schedule (idClass TEXT, start TEXT, finish TEXT, classroom TEXT, day TEXT)');
    db.execute(
            'CREATE TABLE homework (id TEXT PRIMARY KEY, title TEXT, description TEXT, sclass TEXT, date TEXT, type INTEGER)');
      
   }

  static Future<void> insert(
    String table,
    Map<String, Object> data,
  ) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getSchedule(String id, String table) async {
    final db = await DBHelper.database();
    return db.rawQuery('SELECT * FROM schedule WHERE idClass = \"$id\"');
  }
}
