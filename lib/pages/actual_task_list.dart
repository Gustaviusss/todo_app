import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

import '../utils/custom_tile.dart';
import '../widgets/empty_list_widget.dart';

class ActualTaskList extends StatelessWidget {
  const ActualTaskList(
      {super.key,
      required this.taskList,
      required this.removeTask,
      required this.checkTask,
      required this.colorTheme,
      required this.themeIndex});

  final List<TaskModel> taskList;
  final void Function(TaskModel) removeTask;
  final void Function(bool?, int) checkTask;
  final List<Map> colorTheme;
  final int themeIndex;

  @override
  Widget build(BuildContext context) {
    return taskList.isEmpty
        ? const EmptyListWidget(
            emptyListText: 'Sem tarefas por enquanto, que tal criar uma?',
            emptyListIcon: Icons.sentiment_dissatisfied_outlined,
          )
        : ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) => Dismissible(
                  key: ValueKey(index),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      checkTask(true, index);
                    } else if (direction == DismissDirection.endToStart) {
                      removeTask(taskList[index]);
                    }
                  },
                  child: CustomTile(
                      colorTheme: colorTheme,
                      themeIndex: themeIndex,
                      tileText: taskList[index].title,
                      isCompleted: taskList[index].isCompleted,
                      onChecked: (value) => checkTask(value, index)),
                ));
  }
}
