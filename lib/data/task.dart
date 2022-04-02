import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 3)
class Task {
  @HiveField(21)
  String task;

  @HiveField(24)
  List<String>? subtask;

  @HiveField(23)
  bool showTask;

  Task({required this.task, required this.subtask, required this.showTask});
}
