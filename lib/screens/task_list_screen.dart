import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../providers/tasks_provider.dart';
import 'add_edit_task_screen.dart';
import 'task_details_screen.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(tasksProvider);

    // Filter tasks based on search query
    final filteredTasks = tasks.where((task) {
      final query = _searchQuery.toLowerCase();
      return task.title.toLowerCase().contains(query) ||
          (task.description?.toLowerCase().contains(query) ?? false);
    }).toList();

    // Separate tasks into completed and incomplete
    final incompleteTasks = filteredTasks.where((task) => !task.isCompleted).toList();
    final completedTasks = filteredTasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEditTaskScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search tasks...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Progress Indicator
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${completedTasks.length} of ${tasks.length} tasks completed',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          LinearProgressIndicator(
            value: tasks.isEmpty ? 0 : completedTasks.length / tasks.length,
          ),
          Expanded(
            child: AnimationLimiter(
              child: ListView(
                children: [
                  // Incomplete Tasks
                  ..._buildTaskList(incompleteTasks, isCompleted: false),
                  // Completed Tasks
                  if (completedTasks.isNotEmpty) ...[
                    Divider(),
                    Text(
                      'Completed Tasks',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    ..._buildTaskList(completedTasks, isCompleted: true),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTaskList(List tasks, {required bool isCompleted}) {
  return AnimationConfiguration.toStaggeredList(
    duration: const Duration(milliseconds: 300),
    childAnimationBuilder: (widget) => SlideAnimation(
      horizontalOffset: 50.0,
      child: FadeInAnimation(child: widget),
    ),
    children: tasks.asMap().entries.map((entry) {
      final index = entry.key;
      final task = entry.value;

      return ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            ref.read(tasksProvider.notifier).updateTask(
              ref.watch(tasksProvider).indexOf(task),
              task.copyWith(isCompleted: value ?? false),
            );
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description != null) Text(task.description!),
            Text(
              'Due: ${task.dueDate.toLocal().toString().split(' ')[0]}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              'Priority: ${task.priority}',
              style: TextStyle(
                fontSize: 12,
                color: task.priority == 'High'
                    ? Colors.red
                    : task.priority == 'Medium'
                        ? Colors.orange
                        : Colors.green,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailsScreen(
                index: ref.watch(tasksProvider).indexOf(task),
                task: task,
              ),
            ),
          );
        },
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            ref.read(tasksProvider.notifier).deleteTask(
              ref.watch(tasksProvider).indexOf(task),
            );
          },
        ),
      );
    }).toList(),
  );
}

}
