import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TodoProvider.dart';
import 'TaskList.dart';
import 'AddTask.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Todo'),
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        child: Consumer<TodoProvider>(
          builder: (context, todos, child) => ListView(
            children: <Widget>[
              Container(child: TaskList(tasks: todos.allTasks)),
              AddTask(),
            ],
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}
