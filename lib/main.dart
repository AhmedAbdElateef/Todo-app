import 'package:flutter/material.dart';
import 'package:todo_app/screens/bottom_bar/home_page.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo_app',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
