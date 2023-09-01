import 'package:flutter/material.dart';

import '../models/task_model.dart';

class NewTaskDialog extends StatelessWidget {
  const NewTaskDialog(
      {super.key,
      required this.onAddTask,
      required this.colorThemes,
      required this.colorIndex});
  final void Function(TaskModel) onAddTask;
  final List<Map> colorThemes;
  final int colorIndex;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final Color defaultColor = colorThemes[colorIndex]['defaultColor'];
    return AlertDialog(
      titleTextStyle: TextStyle(
        color: defaultColor,
        fontSize: 22,
      ),
      backgroundColor: colorThemes[colorIndex]['dialogColor'],
      title: const Text('Adicionar Tarefa'),
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          autofocus: true,
          cursorColor: defaultColor,
          controller: titleController,
          onSubmitted: (value) {
            titleController.text = value;
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: defaultColor, width: 2)),
            focusColor: defaultColor,
            labelStyle: TextStyle(color: defaultColor),
            border: const UnderlineInputBorder(),
            label: const Text('Título'),
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              titleController.clear();
              Navigator.pop(context);
            },
            child: Text(
              'Cancelar',
              style: TextStyle(fontSize: 12, color: defaultColor),
            )),
        TextButton(
            onPressed: () {
              onAddTask(
                  TaskModel(title: titleController.text, isCompleted: false));
              titleController.clear();
              Navigator.pop(context);
            },
            child: Text(
              'Adicionar',
              style: TextStyle(fontSize: 18, color: defaultColor),
            ))
      ],
    );
  }
}
