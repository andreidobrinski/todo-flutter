import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TaskModel.dart';
import 'TodoProvider.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;

  TaskItem({@required this.task});

  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (bool checked) {
          Provider.of<TodoProvider>(context, listen: false).toggleTodo(task);
        },
      ),
      title: Text(task.title),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          Provider.of<TodoProvider>(context, listen: false).deleteTodo(task);
        },
      ),
    );
  }
}
