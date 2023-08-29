import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  TaskModel({
    required this.title,
    // required this.description,
    required this.isCompleted,
  });
  @HiveField(0)
  String title;
  // String description;
  @HiveField(1)
  bool isCompleted;
}
