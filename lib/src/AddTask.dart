import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'TodoProvider.dart';
import 'TaskModel.dart';

class AddTask extends StatefulWidget {
  @override
  AddTaskState createState() => AddTaskState();
}

class AddTaskState extends State<AddTask> {
  final taskTitleController = TextEditingController();

  @override
  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }

  void onAdd() {
    final String textVal = taskTitleController.text;
    if (textVal.isNotEmpty) {
      final TaskModel todo = TaskModel(
        title: textVal,
      );
      Provider.of<TodoProvider>(context, listen: false).addTodo(todo);
      taskTitleController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(controller: taskTitleController),
            RaisedButton(
              child: Text('Add'),
              onPressed: onAdd,
            ),
          ],
        ),
      ),
    );
  }
}
