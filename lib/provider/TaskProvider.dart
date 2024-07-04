// provider/task_provider.dart

import 'package:flutter/material.dart';
import 'package:taskly/models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }
}
