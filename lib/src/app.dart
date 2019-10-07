import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TodoProvider.dart';
import 'TaskList.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('todo app'),
      ),
      body: Container(
        child: Consumer<TodoProvider>(
          builder: (context, todos, child) => TaskList(
            tasks: todos.allTasks,
          ),
        ),
      ),
    );
  }
}
