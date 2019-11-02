import 'package:flutter/material.dart';
import 'TaskModel.dart';
import 'TaskItem.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> tasks;

  TaskList({@required this.tasks});

  Widget build(BuildContext context) {
    return Column(
      children: getTasks(),
    );
  }

  List<Widget> getTasks() {
    return tasks.map((todo) => TaskItem(task: todo)).toList();
  }
}
