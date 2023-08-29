import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

import '../utils/custom_tile.dart';
import '../widgets/empty_list_widget.dart';

class FinishedTaskList extends StatelessWidget {
  const FinishedTaskList(
      {super.key,
      required this.taskList,
      required this.removeTask,
      required this.colorTheme,
      required this.themeIndex});

  final List<dynamic> taskList;
  final void Function(TaskModel) removeTask;
  final List<Map> colorTheme;
  final int themeIndex;

  @override
  Widget build(BuildContext context) {
    return taskList.isEmpty
        ? const EmptyListWidget(
            emptyListText:
                'Quando Você concluir uma tarefa, ela aparecerá aqui.',
            emptyListIcon: Icons.lightbulb_outline_sharp,
          )
        : ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) => Dismissible(
                  key: ValueKey(index),
                  onDismissed: (direction) => removeTask(taskList[index]),
                  child: CustomTile(
                      colorTheme: colorTheme,
                      themeIndex: themeIndex,
                      tileText: taskList[index].title,
                      isCompleted: taskList[index].isCompleted,
                      onChecked: (value) {}),
                ));
  }
}
