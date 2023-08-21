import 'package:flutter/material.dart';

import '../utils/custom_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();

  List taskList = [
    ['Fazer Janta', false],
    ['Se Exercitar', false]
  ];

  void checkTask(bool? value, int index) {
    setState(() {
      taskList[index][1] = !taskList[index][1];
      final task = taskList.removeAt(index);
      taskList.add(task);
    });
  }

  void removeTask(int index) {
    setState(() {
      taskList.removeAt(index);
    });
  }

  void addTask(String title) {
    setState(() {
      taskList.insert(0, [title.toUpperCase(), false]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        title: const Center(child: Text('TAREFAS')),
        elevation: 0,
      ),
      body: taskList.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.grey[800],
                        size: 50,
                      ),
                      Text(
                        'Sem tarefas por enquanto, que tal criar uma?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 28, color: Colors.grey[800]),
                      )
                    ]),
              ),
            )
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) => Dismissible(
                    key: ValueKey(index),
                    onDismissed: (direction) => removeTask(index),
                    child: CustomTile(
                        tileText: taskList[index][0],
                        isCompleted: taskList[index][1],
                        onChecked: (value) => checkTask(value, index)),
                  )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: const Text('Adicionar Tarefa'),
                    content: TextField(
                      controller: titleController,
                      onChanged: (value) {
                        titleController.text = value;
                      },
                      decoration: const InputDecoration(
                          label: Text('Título'), border: OutlineInputBorder()),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            addTask(titleController.text);
                            titleController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Adicionar',
                            style: TextStyle(fontSize: 16),
                          ))
                    ],
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
