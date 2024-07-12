import 'package:flutter/material.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/widgets/task_dialog.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Future<void> Function()? delete;

  const TaskCard({super.key, required this.task, required this.delete});

  void _showEditTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => TaskDialog(task: task),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
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
                const Icon(Icons.calendar_today,
                    size: 16, color: Color.fromARGB(255, 110, 109, 109)),
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
                  onPressed: () {
                    // Implement complete functionality
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
