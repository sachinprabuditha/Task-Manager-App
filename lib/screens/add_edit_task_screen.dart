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
          child: ListView(
            children: [
              // Title Field
              _buildTextField(
                controller: _titleController,
                label: 'Title',
                validator: (value) => value == null || value.isEmpty ? 'Title is required' : null,
              ),

              SizedBox(height: 16),

              // Description Field
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                maxLines: 3,
              ),

              SizedBox(height: 16),

              // Priority Dropdown
              _buildPriorityDropdown(),

              SizedBox(height: 16),

              // Due Date Field
              _buildDueDateField(),

              SizedBox(height: 24),

              // Save Button
              _buildSaveButton(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          validator: validator,
          maxLines: maxLines,
        ),
      ),
    );
  }

  Widget _buildPriorityDropdown() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: _priority,
          builder: (context, value, _) {
            return DropdownButtonFormField<String>(
              value: value,
              items: [
                DropdownMenuItem(value: 'Low', child: Text('Low')),
                DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                DropdownMenuItem(value: 'High', child: Text('High')),
              ],
              onChanged: (newValue) {
                _priority.value = newValue!;
              },
              decoration: InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDueDateField() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: _dueDate,
          builder: (context, value, _) {
            return TextFormField(
              decoration: InputDecoration(
                labelText: 'Due Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
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
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
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
      child: Text(
        'Save Task',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
