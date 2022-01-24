import 'package:sqflite/sqflite.dart';
import 'package:todo/db/task.dart';
// import 'package:path/path.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "tasks";

  static Future<void> initDb() async {
    if (_db != null) {
      // print("ifffffffffffffffffffff");
      return;
    }

    try {
      print("strarting");
      String _path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("creating a new one");
          return db.execute(
            'CREATE TABLE $_tableName( id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, description TEXT, date STRING, color INTEGER)',
          );
        },
      );
      print("Table creation called");
    } catch (e) {
      print("Error $e");
    }
  }

  static Future<int> insert(Task? task) async {
    print("insert function called");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    // print("query function called");
    return await _db!.query(_tableName);
  }

  static delete(Task task) async {
    print("Delete method Called");
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

// Read Data from table by id
  static readDatabyId(_tableName, itemId) async {
    // var connection = await _db;
    return await _db!.query(_tableName, where: 'id=?', whereArgs: [itemId]);
  }

  // static updateData(_tableName, data) async {
  //   return await _db!
  //       .update(_tableName, data.toJson(), where: 'id=?', whereArgs: [data.id]);
  // }

  // static updateData(data) async {
  //   // Get a reference to the database.
  //   // final db = await database;

  //   // Update the given Dog.
  //   await _db!.update(
  //     'tasks',
  //     data.toJson(),
  //     // Ensure that the Dog has a matching id.
  //     where: "id = ?",
  //     // Pass the Dog's id as a whereArg to prevent SQL injection.
  //     whereArgs: [data.id],
  //   );
  // }

// await updateData(data[id: 0, title: 'Fido', description: 'yutuytyiho']);

  static updateData(int id, String title, String description) async {
    var dbClient = await _db;
    return await dbClient!.rawUpdate(
        'UPDATE $_tableName SET title = \'$title\', description = \'$description\'  WHERE id = \'$id\'');
  }
}
