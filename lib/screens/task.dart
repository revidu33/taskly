// pages/task_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/provider/TaskProvider.dart';
import 'package:taskly/widgets/task_card.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Task Page'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return const TaskCard();
          },
        ));
  }
}
