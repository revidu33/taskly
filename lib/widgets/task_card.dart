import 'package:flutter/material.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/widgets/task_dialog.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Future<void> Function()? delete;
  final Future<void> Function()? complete;

  const TaskCard(
      {super.key, required this.task, required this.delete, this.complete});

  void _showEditTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => TaskDialog(task: task),
    );
  }

  String _getTaskStatus() {
    final DateTime now = DateTime.now();
    final DateTime dueDate = DateFormat.yMMMd().add_jm().parse(task.dueDate);
    if (dueDate.isBefore(now) && task.isCompleted != 1) {
      return 'Overdue';
    } else if (!dueDate.isBefore(now) && task.isCompleted != 1) {
      return 'In Progress';
    } else {
      return 'Completed';
    }
  }

  Color _getTaskStatusColor(String status) {
    switch (status) {
      case 'Overdue':
        return Colors.red;
      case 'In Progress':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String taskStatus = _getTaskStatus();
    final Color statusColor = _getTaskStatusColor(taskStatus);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        taskStatus,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              task.description,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 110, 109, 109),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Color.fromARGB(255, 110, 109, 109),
                ),
                const SizedBox(width: 5),
                Text(
                  task.dueDate,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.black54,
                  onPressed: () => _showEditTaskDialog(context),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () async {
                    if (delete != null) {
                      await delete!();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.check_circle),
                  color: Colors.green,
                  onPressed: () async {
                    if (complete != null) {
                      await complete!();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
