import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_tdd/features/add_task/data/model/task_model.dart';

class DbService {
  Database? _db;

  Future<Database> createDB() async {
    if (_db != null) {
      return _db!;
    }

    String path = join(await getDatabasesPath(), 'task_collection.db');
    _db = await openDatabase(path, version: 1, onCreate: (Database db, int v) {
      db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            dateTime TEXT,
            views INTEGER,
            isDone INTEGER
          );
        ''').catchError((val) => log(val));
    });
    return _db!;
  }

  Future<int?> createItem(TaskModel task) async {
    Database db = await createDB();
    return db.insert('tasks', task.toJson());
  }

  Future<int> updateItem(TaskModel task) async {
    Database db = await createDB();
    return db.update('tasks', task.toJson(),
        where: 'id = ?', whereArgs: [task.id]);
  }

  Future allItems() async {
    Database db = await createDB();
    return db.query('tasks');
  }

  Future<int> deleteItem(int id) async {
    Database db = await createDB();
    return db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
