import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/provider/TaskProvider.dart';
import 'package:taskly/widgets/info_box.dart';
import 'package:taskly/widgets/search_bar.dart';
import 'package:taskly/widgets/task_card.dart';
import 'package:taskly/widgets/task_dialog.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => const TaskDialog(),
    );
  }

  void _showEditTaskDialog(Task task) {
    showDialog(
      context: context,
      builder: (context) => TaskDialog(task: task),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 248, 255),
        appBar: AppBar(
          toolbarHeight: 150,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Your Taskly',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  InfoBox(
                    color: Color.fromARGB(255, 7, 108, 98),
                    textOne: 'complete: ',
                    textTwo: 'incomplete: ',
                    textThree: 'overdue:',
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: Colors.teal[600],
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.tealAccent,
            tabs: [
              Tab(text: 'All Tasks'),
              Tab(text: 'Completed Tasks'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              height: double.infinity,
              child: Consumer<TaskProvider>(
                builder: (context, taskProvider, child) {
                  taskProvider.loadTasks();
                  return ListView.builder(
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Column(
                            children: [
                              SearchInput(),
                              TaskCard(
                                task: taskProvider.tasks[index],
                                delete: () async {
                                  await taskProvider.deleteTask(
                                      taskProvider.tasks[index].id!);
                                },
                                complete: () async {
                                  await taskProvider
                                      .completeTask(taskProvider.tasks[index]);
                                },
                              ),
                            ],
                          ),
                        );
                      }
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 20.0),
                          child: TaskCard(
                            task: taskProvider.tasks[index],
                            delete: () async {
                              taskProvider
                                  .deleteTask(taskProvider.tasks[index].id!);
                            },
                            complete: () async {
                              await taskProvider
                                  .completeTask(taskProvider.tasks[index]);
                            },
                          ));
                    },
                  );
                },
              ),
            ),
            Container(
              height: double.infinity,
              child: Consumer<TaskProvider>(
                builder: (context, taskProvider, child) {
                  taskProvider.loadCompletedTasks();
                  return ListView.builder(
                    itemCount: taskProvider.completedTasks.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20.0),
                        child: TaskCard(
                          task: taskProvider.completedTasks[index],
                          delete: () async {
                            await taskProvider.deleteTask(index);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddTaskDialog(),
          backgroundColor: Colors.teal,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
