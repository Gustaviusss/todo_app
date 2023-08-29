import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/pages/actual_task_list.dart';
import 'package:todo_app/pages/finishedTaskList.dart';
import 'package:todo_app/utils/new_task_dialog.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../theme/theme_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentColorScheme = 0;
  var currentScreen = 0;
  List<TaskModel> taskList = [
    TaskModel(title: 'placeHolder', isCompleted: false)
  ];
  List<TaskModel> finishedTaskList = [];

  void checkTask(bool? value, int index) {
    setState(() {
      taskList[index].isCompleted = !taskList[index].isCompleted;
      final task = taskList.removeAt(index);
      finishedTaskList.add(task);
      taskList.remove(task);
    });
  }

  void removeTask(TaskModel task) {
    setState(() {
      taskList.remove(task);
    });
  }

  void deleteTask(TaskModel task) {
    setState(() {
      finishedTaskList.remove(task);
    });
  }

  void addTask(TaskModel task) {
    if (task.title.trim().isNotEmpty) {
      setState(() {
        taskList.add(task);
        currentScreen = 0;
      });
    } else {
      return;
    }
  }

  void changeScreen(int index) {
    setState(() {
      currentScreen = index;
    });
  }

  void changeColorScheme(int index) {
    setState(() {
      currentColorScheme = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSchemes[currentColorScheme]['bgColor'],
      appBar: AppBar(
        backgroundColor: colorSchemes[currentColorScheme]['bgColor'],
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 500,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: ListView.builder(
                                  itemCount: colorSchemes.length,
                                  itemBuilder: (context, index) => Card(
                                        borderOnForeground: true,
                                        elevation: 2,
                                        color: colorSchemes[index]
                                            ['defaultColor'],
                                        child: GestureDetector(
                                          onTap: () {
                                            changeColorScheme(index);
                                          },
                                          child: ListTile(
                                            title: Text(
                                              colorSchemes[index]['themeName'],
                                              style: TextStyle(
                                                  color: colorSchemes[index]
                                                      ['cardTextColor']),
                                            ),
                                            leading: const Icon(
                                              Icons.sunny,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Ok',
                                    style: TextStyle(fontSize: 20),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.color_lens,
                color: colorSchemes[currentColorScheme]['iconColor'],
              ))
        ],
        title: Center(
            child: Text(
          currentScreen == 0 ? 'TAREFAS A FAZER' : 'TAREFAS FEITAS',
          style:
              TextStyle(color: colorSchemes[currentColorScheme]['titleColor']),
        )),
        elevation: 0,
      ),
      body: currentScreen == 0
          ? ActualTaskList(
              colorTheme: colorSchemes,
              themeIndex: currentColorScheme,
              taskList: taskList,
              removeTask: removeTask,
              checkTask: checkTask,
            )
          : FinishedTaskList(
              colorTheme: colorSchemes,
              themeIndex: currentColorScheme,
              taskList: finishedTaskList,
              removeTask: deleteTask,
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar uma Tarefa',
        backgroundColor: colorSchemes[currentColorScheme]['defaultColor'],
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => NewTaskDialog(onAddTask: addTask),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: colorSchemes[currentColorScheme]['bgColor'],
          buttonBackgroundColor: Colors.transparent,
          color: colorSchemes[currentColorScheme]['mainColor'],
          animationDuration: const Duration(milliseconds: 300),
          index: currentScreen,
          onTap: (index) {
            changeScreen(index);
          },
          items: [
            Icon(
              Icons.list_alt,
              color: colorSchemes[currentColorScheme]['iconColor'],
              size: 36,
            ),
            Icon(
              Icons.playlist_add_check,
              color: colorSchemes[currentColorScheme]['iconColor'],
              size: 42,
            ),
          ]),
    );
  }
}
