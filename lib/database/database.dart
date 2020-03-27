import 'package:dooit/database/dao/todo_item_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'dooit.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(TodoItemDao.tableSql);
    },
    version: 1,
  );
}
