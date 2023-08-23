import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

import '../utils/custom_tile.dart';
import '../widgets/empty_list_widget.dart';

class ActualTaskList extends StatelessWidget {
  const ActualTaskList(
      {super.key,
      required this.taskList,
      required this.removeTask,
      required this.checkTask});

  final List<TaskModel> taskList;
  final void Function(TaskModel) removeTask;
  final void Function(bool?, int) checkTask;

  @override
  Widget build(BuildContext context) {
    return taskList.isEmpty
        ? const EmptyListWidget()
        : ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) => Dismissible(
                  key: ValueKey(index),
                  onDismissed: (direction) => removeTask(taskList[index]),
                  child: CustomTile(
                      tileText: taskList[index].title,
                      isCompleted: taskList[index].isCompleted,
                      onChecked: (value) => checkTask(value, index)),
                ));
  }
}
