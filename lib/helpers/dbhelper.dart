import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as pth;

class DBhelper {
  static Future<void> delete(String table, int id) async {
    final dbpath = await sql.getDatabasesPath();
    final sqldb = await sql.openDatabase(pth.join(dbpath, "places.db"),
        onCreate: (db, version) {
      return db.execute("CREATE TABLE cities(id TEXT PRIMARY KEY, name TEXT)");
    }, version: 1);
    print("the id");
    print(id);
    await sqldb.execute("DELETE FROM cities WHERE id=$id");
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbpath = await sql.getDatabasesPath();
    final sqldb = await sql.openDatabase(pth.join(dbpath, "places.db"),
        onCreate: (db, version) {
      return db.execute("CREATE TABLE cities(id TEXT PRIMARY KEY, name TEXT)");
    }, version: 1);

    await sqldb.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetchdata(String table) async {
    final dbpath = await sql.getDatabasesPath();
    final sqldb = await sql.openDatabase(pth.join(dbpath, "places.db"),
        onCreate: (db, version) {
      return db.execute("CREATE TABLE cities(id TEXT PRIMARY KEY, name TEXT)");
    }, version: 1);

    return sqldb.query(table);
  }
}
