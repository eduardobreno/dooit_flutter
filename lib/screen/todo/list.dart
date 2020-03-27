import 'package:dooit/database/dao/todo_item_dao.dart';
import 'package:dooit/screen/todo/components/todo_item_comp.dart';
import 'package:flutter/material.dart';
import 'package:dooit/models/todo_item.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoItemDao _dao = TodoItemDao();
  List<TodoItem> todoList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      todoList = await _dao.findAll();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo list"),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView.builder(
          itemCount: todoList.length + 1,
          itemBuilder: (context, index) {
            if (index < todoList.length) {
              final TodoItem data = todoList[index];
              // print(data.toString());
              return TodoItemComp(
                isChecked: data.isDone,
                text: data.description,
                onCheck: () async {
                  await _dao.update(
                      TodoItem(data.id, data.description, !data.isDone));
                  setState(() {
                    todoList[index] =
                        TodoItem(data.id, data.description, !data.isDone);
                  });
                },
                onChange: (text) async {
                  todoList[index] = TodoItem(data.id, text, data.isDone);
                },
                onBlur: (text) async {
                  _dao.update(TodoItem(data.id, text, data.isDone));
                  setState(() {});
                },
                delete: () async {
                  await _dao.deleteById(data.id);
                  setState(() {
                    todoList.removeAt(index);
                  });
                },
              );
            }
            if (todoList.length == 0 || index == todoList.length) {
              return RaisedButton(
                onPressed: () async {
                  setState(() {
                    todoList.add(TodoItem(0, "", false));
                  });
                },
                child: Text("oi"),
              );
            }
            return Text('Unknown error');
          },
        ),
      ),
    );
  }
}
