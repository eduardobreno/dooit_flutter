import 'package:dooit/database/database.dart';
import 'package:dooit/models/todo_item.dart';
import 'package:sqflite/sqflite.dart';

class TodoItemDao {
  static const String _tableName = 'todos';
  static const String _id = 'id';
  static const String _description = 'description';
  static const String _isDone = 'is_done';
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_description TEXT, '
      '$_isDone INTEGER)';

  Future<int> save(TodoItem data) async {
    final Database db = await getDatabase();
    Map<String, dynamic> dataMap = _toMap(data);
    return db.insert(_tableName, dataMap);
  }

  Future<int> update(TodoItem data) async {
    final Database db = await getDatabase();
    final exist = await _checkId(data.id);
    if (exist) {
      final result = await db.rawUpdate(
          'UPDATE $_tableName SET $_description=\'${data.description}\', $_isDone=\'${data.isDone ? 1 : 0}\' '
          ' WHERE id=${data.id}');
      return result;
    }
    return await save(data);
  }

  Future<List<TodoItem>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    return _toList(result);
  }

  Future<bool> _checkId(int id) async {
    final Database db = await getDatabase();

    final List<Map> result = await db.query('$_tableName WHERE id=$id');
    return result.length > 0;
  }

  Future<int> deleteById(int id) async {
    final Database db = await getDatabase();
    final int result =
        await db.rawDelete('DELETE FROM $_tableName WHERE id=$id');
    return result;
  }

  Map<String, dynamic> _toMap(TodoItem data) {
    final Map<String, dynamic> dataMap = Map();
    dataMap[_description] = data.description;
    dataMap[_isDone] = data.isDone ? 1 : 0;
    return dataMap;
  }

  List<TodoItem> _toList(List<Map<String, dynamic>> result) {
    final List<TodoItem> datas = List();
    for (Map<String, dynamic> row in result) {
      final TodoItem data = TodoItem(
        row[_id],
        row[_description],
        row[_isDone] == 1 ? true : false,
      );
      datas.add(data);
    }
    return datas;
  }
}
