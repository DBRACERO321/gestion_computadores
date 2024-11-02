import 'package:computers_crud/entities/computer/computer.entity.dart';
import 'package:sqflite/sqflite.dart' as SQL;

class ComputerHelper {
  static Future<void> createTable(SQL.Database database) async {
    await database.execute("""
              CREATE TABLE computers(
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              model TEXT,
              processor TEXT,
              hardDisk TEXT,
              ram TEXT
              )
              """);
  }

  static Future<SQL.Database> db() async {
    return SQL.openDatabase("computers.db", version: 1,
        onCreate: (SQL.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<int> insert(Computer computer) async {
    final db = await ComputerHelper.db();
    final id = await db.insert('computers', computer.toMap(),
        conflictAlgorithm: SQL.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> update(Computer computer) async {
    final db = await ComputerHelper.db();
    final id = await db.update('computers', computer.toMap(),
        where: 'id=?', whereArgs: [computer.id]);
    return id;
  }

  static Future<int> delete(int id) async {
    final db = await ComputerHelper.db();
    return await db.delete('computers', where: 'id=?', whereArgs: [id]);
  }

  static Future<List<Computer>> getAllComputers() async {
    final db = await ComputerHelper.db();
    final List<Map<String, dynamic>> maps =
        await db.query('computers', orderBy: 'id');
    return List<Computer>.from(maps.map((map) => Computer.fromMap(map)));
  }
}
