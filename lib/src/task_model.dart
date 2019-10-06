import 'package:flutter/material.dart';

class TaskModel {
  String title;
  bool complete;

  TaskModel({@required this.title, this.complete = false});

  void toggleComplete() {
    complete = !complete;
  }
}
