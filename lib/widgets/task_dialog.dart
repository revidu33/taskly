import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/provider/TaskProvider.dart';
import 'package:intl/intl.dart';

class TaskDialog extends StatefulWidget {
  final Task? task;

  const TaskDialog({super.key, this.task});

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      final dateTime = DateFormat.yMMMd().add_jm().parse(widget.task!.dueDate);
      _selectedDate = dateTime;
      _selectedTime = TimeOfDay.fromDateTime(dateTime);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null && _selectedDate!.isAfter(currentDate)
          ? _selectedDate!
          : currentDate,
      firstDate: currentDate,
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.teal,
              onPrimary: Colors.white,
              surface: Colors.teal[50]!,
              onSurface: Colors.teal[800]!,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked.isAfter(currentDate)) {
      setState(() {
        _selectedDate = picked;
      });
    } else {
      // Show an error message or handle invalid date selection if needed
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.teal,
              onPrimary: Colors.white,
              surface: Colors.teal[50]!,
              onSurface: Colors.teal[800]!,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  String _formatDateTime(DateTime date, TimeOfDay time) {
    final DateTime combined = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    return DateFormat.yMMMd().add_jm().format(combined);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.teal[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.task == null ? 'Add New Task' : 'Edit Task',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[900],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.teal[800]),
                    fillColor: Colors.white,
                    filled: true,
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.teal[800]),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => _selectDate(context),
                      child: Text(
                        _selectedDate == null
                            ? 'Select Date'
                            : DateFormat.yMMMd().format(_selectedDate!),
                        style: TextStyle(color: Colors.teal[800]),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      onPressed: () => _selectTime(context),
                      child: Text(
                        _selectedTime == null
                            ? 'Select Time'
                            : _selectedTime!.format(context),
                        style: TextStyle(color: Colors.teal[800]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.teal)),
        ),
        TextButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty &&
                _selectedDate != null &&
                _selectedTime != null) {
              final dueDate = _formatDateTime(_selectedDate!, _selectedTime!);
              final task = Task(
                id: widget.task?.id,
                title: _titleController.text,
                description: _descriptionController.text,
                dueDate: dueDate,
              );
              final taskProvider =
                  Provider.of<TaskProvider>(context, listen: false);
              if (widget.task == null) {
                taskProvider.addTask(task);
              } else {
                taskProvider.updateTask(task);
              }
              Navigator.of(context).pop();
            }
          },
          child: Text(
            widget.task == null ? 'Add Task' : 'Update Task',
            style: const TextStyle(color: Colors.teal),
          ),
        ),
      ],
    );
  }
}
