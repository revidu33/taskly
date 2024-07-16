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
      version: 2,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, dueDate TEXT, isCompleted INTEGER DEFAULT 0)',
        );
        db.execute(
          'CREATE TABLE comments(id INTEGER PRIMARY KEY AUTOINCREMENT, taskId INTEGER, comment TEXT, FOREIGN KEY(taskId) REFERENCES tasks(id) ON DELETE CASCADE)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE tasks ADD COLUMN isCompleted INTEGER DEFAULT 0',
          );
        }
      },
    );
  }

  Future<int> insertTask(Map<String, dynamic> task) async {
    try {
      Database db = await database;
      return await db.insert('tasks', task);
    } catch (e) {
      print('Error inserting task: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      Database db = await database;
      return await db.query('tasks');
    } catch (e) {
      print('Error getting tasks: $e');
      return [];
    }
  }

  Future<int> updateTask(Map<String, dynamic> task) async {
    try {
      Database db = await database;
      return await db
          .update('tasks', task, where: 'id = ?', whereArgs: [task['id']]);
    } catch (e) {
      print('Error updating task: $e');
      return -1;
    }
  }

  Future<int> deleteTask(int id) async {
    try {
      Database db = await database;
      return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting task: $e');
      return -1;
    }
  }

  Future<int> insertComment(Map<String, dynamic> comment) async {
    try {
      Database db = await database;
      return await db.insert('comments', comment);
    } catch (e) {
      print('Error inserting comment: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getComments(int taskId) async {
    try {
      Database db = await database;
      return await db
          .query('comments', where: 'taskId = ?', whereArgs: [taskId]);
    } catch (e) {
      print('Error getting comments: $e');
      return [];
    }
  }

  Future<int> updateComment(Map<String, dynamic> comment) async {
    try {
      Database db = await database;
      return await db.update('comments', comment,
          where: 'id = ?', whereArgs: [comment['id']]);
    } catch (e) {
      print('Error updating comment: $e');
      return -1;
    }
  }

  Future<int> deleteComment(int id) async {
    try {
      Database db = await database;
      return await db.delete('comments', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting comment: $e');
      return -1;
    }
  }
}
