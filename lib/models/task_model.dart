import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  final String priority;

  @HiveField(3)
  final DateTime dueDate;

  @HiveField(4)
  final bool isCompleted;

  Task({
    required this.title,
    this.description,
    required this.priority,
    required this.dueDate,
    this.isCompleted = false,
  });

  Task copyWith({
    String? title,
    String? description,
    String? priority,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
