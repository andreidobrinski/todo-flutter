import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/src/TaskModel.dart';

final String tableTodos = 'todos';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnComplete = 'complete';
final String columnDateCompleted = 'dateCompleted';

class DatabaseHelper {
  static final _databaseName = "todos_database.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableTodos (
                $columnId INTEGER PRIMARY KEY,
                $columnTitle TEXT NOT NULL,
                $columnComplete INTEGER NOT NULL,
                $columnDateCompleted TEXT
              )
              ''');
  }

  Future<List<TaskModel>> getAllTasks() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableTodos);

    return List.generate(maps.length, (i) {
      return TaskModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        complete: maps[i]['complete'] == 1 ? true : false,
        dateCompleted: maps[i]['dateCompleted'],
      );
    });
  }

  Future<int> insertTask(TaskModel task) async {
    Database db = await database;
    int id = await db.insert(tableTodos, task.toMap());
    return id;
  }

  Future<void> deleteTask(int id) async {
    Database db = await database;

    await db.delete(
      tableTodos,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> updateTask(TaskModel task) async {
    Database db = await database;

    await db.update(
      tableTodos,
      task.toMap(),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

  // Future<TaskModel> queryWord(int id) async {
  //   Database db = await database;
  //   List<Map> maps = await db.query(tableTodos,
  //       columns: [columnId, columnTitle, columnComplete],
  //       where: '$columnId = ?',
  //       whereArgs: [id]);
  //   if (maps.length > 0) {
  //     return TaskModel.fromMap(maps.first);
  //   }
  //   return null;
  // }
}
