import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'TodoProvider.dart';
import 'TaskModel.dart';
import 'DatabaseHelper.dart';

class AddTask extends StatefulWidget {
  @override
  AddTaskState createState() => AddTaskState();
}

class AddTaskState extends State<AddTask> {
  final taskTitleController = TextEditingController();
  bool showTextField = false;

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
      setState(() {
        showTextField = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!showTextField) {
      return RaisedButton(
          child: Text(
            'Add New Todo',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.blue,
          onPressed: () {
            setState(() {
              showTextField = true;
            });
          });
    }
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: taskTitleController,
              autofocus: true,
            ),
            RaisedButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.blue,
              onPressed: onAdd,
            ),
          ],
        ),
      ),
    );
  }
}
