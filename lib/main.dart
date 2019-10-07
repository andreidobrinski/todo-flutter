import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';
import 'src/TodoProvider.dart';

void main() {
  runApp(Todos());
}

class Todos extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => TodoProvider(),
      child: MaterialApp(
        title: 'Todos',
        home: App(),
      ),
    );
  }
}
