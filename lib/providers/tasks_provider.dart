import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/task_model.dart';

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]) {
    loadTasks();
  }

  void loadTasks() async {
    final box = Hive.box<Task>('tasks');
    state = box.values.toList();
  }

  void addTask(Task task) {
    final box = Hive.box<Task>('tasks');
    box.add(task);
    state = [...state, task];
  }

  void updateTask(int index, Task task) {
    final box = Hive.box<Task>('tasks');
    box.putAt(index, task);
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) task else state[i],
    ];
  }

  void deleteTask(int index) {
    final box = Hive.box<Task>('tasks');
    box.deleteAt(index);
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }
}
