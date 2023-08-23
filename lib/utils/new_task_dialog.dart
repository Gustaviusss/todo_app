import 'package:flutter/material.dart';

import '../models/task_model.dart';

class NewTaskDialog extends StatelessWidget {
  const NewTaskDialog({
    super.key,
    required this.onAddTask,
  });
  final void Function(TaskModel) onAddTask;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    return AlertDialog(
      title: const Text('Adicionar Tarefa'),
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: titleController,
          onSubmitted: (value) {
            titleController.text = value;
          },
          decoration: const InputDecoration(
              label: Text('Título'), border: OutlineInputBorder()),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              titleController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(fontSize: 10),
            )),
        TextButton(
            onPressed: () {
              onAddTask(
                  TaskModel(title: titleController.text, isCompleted: false));
              titleController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              'Adicionar',
              style: TextStyle(fontSize: 18),
            ))
      ],
    );
  }
}
