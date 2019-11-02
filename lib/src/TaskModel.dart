import 'package:flutter/material.dart';

class TaskModel {
  int id;
  String title;
  bool complete;
  dynamic dateCompleted;

  TaskModel({
    this.id,
    @required this.title,
    this.complete = false,
    this.dateCompleted,
  });

  void toggleComplete() {
    if (!complete) {
      dateCompleted = DateTime.now().toString();
    } else {
      dateCompleted = null;
    }
    complete = !complete;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'complete': complete == true ? 1 : 0,
      'dateCompleted': dateCompleted,
    };
  }

  TaskModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    complete = map['complete'] == 1 ? true : false;
    dateCompleted = map['dateCompleted'];
  }

  @override
  String toString() {
    return 'Task{id: $id, title: $title, complete: $complete, date completed: $dateCompleted}';
  }
}
