import 'package:school_app/providers/homework.dart';
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

  static void _createDb(sql.Database db) {
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

  static Future<void> update(
    String id,
    String table,
    Map<String, dynamic> data,
  ) async {
    final db = await DBHelper.database();

    if (table == 'classes') {
      db.rawUpdate(
        'UPDATE $table SET id=\'${data['id']}\', title=\'${data['title']}\', teacher=\'${data['teacher']}\', color=\'${data['color']}\' WHERE id=\'${data['id']}\'',
      );
    }else{
      db.rawUpdate(
        'UPDATE $table SET id=\'${data['id']}\', title=\'${data['title']}\', description=\'${data['description']}\', sclass=\'${data['sclass']}\', date=\'${data['date']}\', type=\'${data['type']}\' WHERE id=\'${data['id']}\'',
      );
    }
  }

  static Future<void> deleteClasses(
      String table, String classes, String id) async {
    final db = await DBHelper.database();

    await db.delete(table, where: 'title =\'$classes\'');
    await db.delete('homework', where: 'sclass=\'$classes\'');
    await db.delete('schedule', where: 'idClass=\'$id\'');
  }

  static Future<void> deleteHomework(String id) async{
    final db = await DBHelper.database();

    await db.delete('homework', where: 'id=\'$id\'');

  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getSchedule(
      String id, String table) async {
    final db = await DBHelper.database();
    return db.rawQuery('SELECT * FROM schedule WHERE idClass = \"$id\"');
  }

  static Future<void> updateSchedule(
      String idClass, Map<String, dynamic> schedule) async {
    final db = await DBHelper.database();

    await db.delete('schedule', where: 'idClass = \'$idClass\'');
    await db.insert(
      'schedule',
      schedule,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateHomeworkClasses(
      String prevClass, String newclass) async {
    final db = await DBHelper.database();
    return db.rawUpdate(
        'UPDATE homework SET sclass=\'$newclass\' WHERE sclass=\'$prevClass\'');
  }
}
