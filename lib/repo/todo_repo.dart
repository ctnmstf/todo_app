import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/todo.dart';

class ToDoRepo {
  static final ToDoRepo toDoRepo = ToDoRepo();

  Database? database;

  Future<Database> get db async {
    if (database != null) {
      return database!;
    } else {
      database = await createDatabase();
      return database!;
    }
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "todo.db");
    var database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Todo(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, status INTEGER)');
    });
    return database;
  }

  Future<List<ToDo>> getAllToDo() async {
    final db = await toDoRepo.db;
    var result = await db.query('Todo');
    List<ToDo> toDo = result.isNotEmpty
        ? result.map((item) => ToDo.fromJSON(item)).toList()
        : [];
    return toDo;
  }

  Future<int> createToDo(ToDo toDo) async {
    final db = await toDoRepo.db;
    var result = db.insert('Todo', toDo.toJSON());
    return result;
  }

  Future<int> updateToDo(ToDo toDo) async {
    final db = await toDoRepo.db;
    var result = await db
        .update('Todo', toDo.toJSON(), where: 'id = ?', whereArgs: [toDo.id]);
    return result;
  }

  Future<int> deleteToDo(int id) async {
    final db = await toDoRepo.db;
    var result = db.delete('Todo', where: 'id = ?', whereArgs: [id]);
    return result;
  }
}
