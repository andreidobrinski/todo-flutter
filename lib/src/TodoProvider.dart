import 'dart:collection';
import 'package:flutter/material.dart';
import 'TaskModel.dart';
import 'DatabaseHelper.dart';

class TodoProvider extends ChangeNotifier {
  DatabaseHelper helper = DatabaseHelper.instance;

  List<TaskModel> _tasks = [];

  Future<List<TaskModel>> getTasks() async {
    return await helper.getAllTasks();
  }

  TodoProvider() {
    getTasks().then((tasks) {
      _tasks = tasks;
      tasks.forEach((task) {
        if (task.dateCompleted != null) {
          int difference = DateTime.now()
              .difference(DateTime.parse(task.dateCompleted))
              .inDays;
          if (difference > 7) {
            toggleTodo(task);
          }
        }
      });
      notifyListeners();
    });
  }

  UnmodifiableListView<TaskModel> get allTasks => UnmodifiableListView(_tasks);

  void toggleTodo(TaskModel task) async {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleComplete();
    await helper.updateTask(task);
    notifyListeners();
  }

  void addTodo(TaskModel task) async {
    _tasks.add(task);
    await helper.insertTask(task);
    notifyListeners();
  }

  void deleteTodo(TaskModel task) async {
    _tasks.remove(task);
    await helper.deleteTask(task.id);
    notifyListeners();
  }
}
