import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../providers/tasks_provider.dart';
import 'add_edit_task_screen.dart';

class TaskDetailsScreen extends ConsumerWidget {
  final int index;
  final Task task;

  TaskDetailsScreen({required this.index, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              ref.read(tasksProvider.notifier).deleteTask(index);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${task.title}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Description: ${task.description ?? 'No description'}'),
            SizedBox(height: 10),
            Text('Priority: ${task.priority}'),
            SizedBox(height: 10),
            Text('Due Date: ${task.dueDate.toLocal()}'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditTaskScreen(index: index, task: task),
                  ),
                );
              },
              child: Text('Edit Task'),
            ),
          ],
        ),
      ),
    );
  }
}