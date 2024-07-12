import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/provider/TaskProvider.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        margin: const EdgeInsets.all(20),
        width: 350,
        height: 300,
        child: Row(
          children: [
            Container(
              width: 20, // Adjust the width as needed
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 32, 220, 15),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(90),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
            Expanded(
              child: Padding(
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
                    const Spacer(),
                    Row(
                      children: [
                        const Text(
                          'Due:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 110, 109, 109),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.black,
                          onPressed: () {
                            // Implement edit functionality
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.black,
                          onPressed: () {
                            // Implement delete functionality
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
            ),
          ],
        ),
      ),
    );
  }
}
