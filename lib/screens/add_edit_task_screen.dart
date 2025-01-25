import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/tasks_provider.dart';
import '../models/task_model.dart';

class AddEditTaskScreen extends ConsumerWidget {
  final int? index;
  final Task? task;

  AddEditTaskScreen({this.index, this.task});

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priority = ValueNotifier<String>('Low');
  final _dueDate = ValueNotifier<DateTime>(DateTime.now());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (task != null) {
      _titleController.text = task!.title;
      _descriptionController.text = task!.description ?? '';
      _priority.value = task!.priority;
      _dueDate.value = task!.dueDate;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Title is required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              ValueListenableBuilder(
                valueListenable: _priority,
                builder: (context, value, _) {
                  return DropdownButtonFormField(
                    value: value,
                    items: [
                      DropdownMenuItem(value: 'Low', child: Text('Low')),
                      DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'High', child: Text('High')),
                    ],
                    onChanged: (newValue) {
                      _priority.value = newValue!;
                    },
                    decoration: InputDecoration(labelText: 'Priority'),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: _dueDate,
                builder: (context, value, _) {
                  return TextFormField(
                    decoration: InputDecoration(labelText: 'Due Date'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: value,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        _dueDate.value = pickedDate;
                      }
                    },
                    controller: TextEditingController(text: value.toLocal().toString().split(' ')[0]),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newTask = Task(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      priority: _priority.value,
                      dueDate: _dueDate.value,
                    );

                    if (index != null) {
                      ref.read(tasksProvider.notifier).updateTask(index!, newTask);
                    } else {
                      ref.read(tasksProvider.notifier).addTask(newTask);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}