import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'task_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, dueDate TEXT)',
        );
        db.execute(
          'CREATE TABLE comments(id INTEGER PRIMARY KEY AUTOINCREMENT, taskId INTEGER, comment TEXT, FOREIGN KEY(taskId) REFERENCES tasks(id) ON DELETE CASCADE)',
        );
      },
    );
  }

  Future<int> insertTask(Map<String, dynamic> task) async {
    Database db = await database;
    return await db.insert('tasks', task);
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    Database db = await database;
    return await db.query('tasks');
  }

  Future<int> updateTask(Map<String, dynamic> task) async {
    Database db = await database;
    return await db
        .update('tasks', task, where: 'id = ?', whereArgs: [task['id']]);
  }

  Future<int> deleteTask(int id) async {
    Database db = await database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertComment(Map<String, dynamic> comment) async {
    Database db = await database;
    return await db.insert('comments', comment);
  }

  Future<List<Map<String, dynamic>>> getComments(int taskId) async {
    Database db = await database;
    return await db.query('comments', where: 'taskId = ?', whereArgs: [taskId]);
  }

  Future<int> updateComment(Map<String, dynamic> comment) async {
    Database db = await database;
    return await db.update('comments', comment,
        where: 'id = ?', whereArgs: [comment['id']]);
  }

  Future<int> deleteComment(int id) async {
    Database db = await database;
    return await db.delete('comments', where: 'id = ?', whereArgs: [id]);
  }
}
