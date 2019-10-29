import 'package:flutter/material.dart';

class TaskModel {
  int id;
  String title;
  bool complete;

  TaskModel({
    this.id,
    @required this.title,
    this.complete = false,
  });

  void toggleComplete() {
    complete = !complete;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'complete': complete == true ? 1 : 0,
    };
  }

  TaskModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    complete = map['complete'] == 1 ? true : false;
  }

  @override
  String toString() {
    return 'Task{title: $title, complete: $complete}';
  }
}
