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
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              ref.read(tasksProvider.notifier).deleteTask(index);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Description
            _buildTitleDescriptionSection(),

            SizedBox(height: 20),

            // Priority and Status Section
            _buildPriorityStatusSection(),

            SizedBox(height: 20),

            // Due Date
            _buildDueDateSection(),

            SizedBox(height: 20),

            // Edit Button
            _buildEditButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleDescriptionSection() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${task.title}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Description: ${task.description ?? 'No description'}',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityStatusSection() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.priority_high,
                  color: _getPriorityColor(task.priority),
                  size: 28,
                ),
                SizedBox(width: 10),
                Text(
                  'Priority: ${task.priority}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  task.isCompleted ? Icons.check_circle : Icons.circle,
                  color: task.isCompleted ? Colors.green : Colors.grey,
                  size: 28,
                ),
                SizedBox(width: 10),
                Text(
                  'Status: ${task.isCompleted ? 'Completed' : 'Pending'}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDueDateSection() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Colors.blue,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Due Date: ${task.dueDate.toLocal().toString().split(' ')[0]}', // Format the date to show only the date part
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEditTaskScreen(index: index, task: task),
          ),
        );
      },
      child: Text(
        'Edit Task',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
