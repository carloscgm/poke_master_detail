import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseHelper {
  DatabaseHelper(this.dbName);

  final String dbName;
  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<String> get dbPath async {
    return join(
        (await getApplicationSupportDirectory()).path, 'databases', dbName);
  }

  Future<List<Map<String, Object?>>> getAll(String table) async {
    final database = await db;
    return await database.query(table);
  }

  Future<Map<String, Object?>> get(
      String table, MapEntry<String, dynamic> id) async {
    final database = await db;
    return (await database.query(table,
            where: '${id.key} = ?', whereArgs: [id.value], limit: 1))
        .first;
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    final database = await db;
    await database.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(String table, MapEntry<String, dynamic> id,
      Map<String, dynamic> data) async {
    final database = await db;
    await database.update(
      table,
      data,
      where: '${id.key} = ?',
      whereArgs: [id.value],
    );
  }

  Future<void> delete(String table, MapEntry<String, dynamic> id) async {
    final database = await db;
    await database.delete(
      table,
      where: '${id.key} = ?',
      whereArgs: [id.value],
    );
  }

  Future<void> deleteAll(String table) async {
    final database = await db;
    await database.query('delete from $table');
  }

  _initDb() async {
    return await openDatabase(await dbPath, version: 1, onCreate: onCreate);
  }

  void onCreate(Database db, int version);
}
