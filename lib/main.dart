import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dooit/screen/todo/list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;

    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      // themeMode: ThemeMode.dark,
      home: TodoListScreen(),
    );
  }
}
