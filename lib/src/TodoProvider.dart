import 'dart:collection';
import 'package:flutter/material.dart';
import 'TaskModel.dart';

class TodoProvider extends ChangeNotifier {
  final List<TaskModel> _tasks = [
    TaskModel(title: 'Add the first task'),
  ];

  UnmodifiableListView<TaskModel> get allTasks => UnmodifiableListView(_tasks);

  void toggleTodo(TaskModel task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleComplete();
    notifyListeners();
  }

  void addTodo(TaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTodo(TaskModel task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
