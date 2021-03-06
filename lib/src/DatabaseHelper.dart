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

    var incomplete = maps.where((item) => item['dateCompleted'] == null);
    var complete = maps.where((item) => item['dateCompleted'] != null);
    var ordered = List.from(incomplete)..addAll(complete);

    return List.generate(ordered.length, (i) {
      return TaskModel(
        id: ordered[i]['id'],
        title: ordered[i]['title'],
        complete: ordered[i]['complete'] == 1 ? true : false,
        dateCompleted: ordered[i]['dateCompleted'],
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
}
