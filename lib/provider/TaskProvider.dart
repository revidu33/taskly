import 'package:flutter/foundation.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/models/comment.dart';
import 'package:taskly/services/db/local_db_helper.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Comment> _comments = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Task> get tasks => _tasks;
  List<Comment> get comments => _comments;

  // db related tasks

  Future<void> loadTasks() async {
    final dataList = await _dbHelper.getTasks();
    _tasks = dataList.map((item) => Task.fromMap(item)).toList();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _dbHelper.insertTask(task.toMap());
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _dbHelper.updateTask(task.toMap());
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    await loadTasks();
  }

  Future<void> loadComments(int taskId) async {
    final dataList = await _dbHelper.getComments(taskId);
    _comments = dataList.map((item) => Comment.fromMap(item)).toList();
    notifyListeners();
  }

  Future<void> addComment(Comment comment) async {
    await _dbHelper.insertComment(comment.toMap());
    await loadComments(comment.taskId);
  }

  Future<void> updateComment(Comment comment) async {
    await _dbHelper.updateComment(comment.toMap());
    await loadComments(comment.taskId);
  }

  Future<void> deleteComment(int id, int taskId) async {
    await _dbHelper.deleteComment(id);
    await loadComments(taskId);
  }

  // search bar
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Task> filterTasks(List<Task> tasks) {
    if (_searchQuery.isEmpty) {
      return tasks;
    } else {
      return tasks.where((task) {
        return task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            task.description.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }
}
