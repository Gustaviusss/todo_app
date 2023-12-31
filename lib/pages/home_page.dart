import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/pages/actual_task_list.dart';
import 'package:todo_app/pages/finished_task_list.dart';
import 'package:todo_app/utils/new_task_dialog.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //acess hive box
  final _dataBox = Hive.box('dataBox');
  ToDoDataBase db = ToDoDataBase();

  var currentScreen = 0;

  @override
  void initState() {
    if (_dataBox.get("TASKLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  void checkTask(bool? value, int index) {
    setState(() {
      db.taskList[index].isCompleted = !db.taskList[index].isCompleted;
      final task = db.taskList.removeAt(index);
      db.finishedTaskList.add(task);
      db.taskList.remove(task);
    });
    db.updateData();
    Fluttertoast.showToast(
        fontSize: 16,
        backgroundColor: db.colorSchemes[db.currentColorScheme]
            ['finishedColor'],
        msg: 'Tarefa Concluída');
  }

  void removeTask(TaskModel task) {
    setState(() {
      db.taskList.remove(task);
    });
    db.updateData();
    Fluttertoast.showToast(
        fontSize: 16,
        backgroundColor: db.colorSchemes[db.currentColorScheme]
            ['finishedColor'],
        msg: 'Tarefa Deletada');
  }

  void deleteTask(TaskModel task) {
    setState(() {
      db.finishedTaskList.remove(task);
    });
    db.updateData();
    Fluttertoast.showToast(
        fontSize: 16,
        backgroundColor: db.colorSchemes[db.currentColorScheme]
            ['finishedColor'],
        msg: 'Tarefa Deletada');
  }

  void addTask(TaskModel task) {
    if (task.title.trim().isNotEmpty) {
      setState(() {
        db.taskList.add(task);
        currentScreen = 0;
      });
    } else {
      return;
    }
    db.updateData();
    Fluttertoast.showToast(
        fontSize: 16,
        backgroundColor: db.colorSchemes[db.currentColorScheme]
            ['finishedColor'],
        msg: 'Tarefa Adicionada');
  }

  void changeScreen(int index) {
    setState(() {
      currentScreen = index;
    });
  }

  void changeColorScheme(int index) {
    setState(() {
      db.currentColorScheme = index;
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: db.colorSchemes[db.currentColorScheme]['bgColor'],
      appBar: AppBar(
        backgroundColor: db.colorSchemes[db.currentColorScheme]['bgColor'],
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    useSafeArea: true,
                    context: context,
                    builder: (_) => Dialog(
                        backgroundColor: db.colorSchemes[db.currentColorScheme]
                            ['dialogColor'],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Escolha um Tema',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height: 500,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: db.colorSchemes.length,
                                    itemBuilder: (context, index) => Card(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          borderOnForeground: true,
                                          elevation: 2,
                                          color: db.colorSchemes[index]
                                              ['defaultColor'],
                                          child: GestureDetector(
                                            onTap: () {
                                              changeColorScheme(index);
                                            },
                                            child: ListTile(
                                              title: Text(
                                                db.colorSchemes[index]
                                                    ['themeName'],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              leading: Icon(
                                                db.colorSchemes[index]
                                                    ['themeIcon'],
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(bottom: 30),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Ok',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: db.colorSchemes[
                                                db.currentColorScheme]
                                            ['defaultColor']),
                                  ),
                                ))
                          ],
                        )));
              },
              icon: Icon(
                Icons.color_lens,
                color: db.colorSchemes[db.currentColorScheme]['iconColor'],
                size: 28,
              ))
        ],
        title: Text(
          currentScreen == 0 ? 'TAREFAS A FAZER' : 'TAREFAS FEITAS',
          style: TextStyle(
              color: db.colorSchemes[db.currentColorScheme]['titleColor']),
        ),
        elevation: 0,
      ),
      body: AnimatedCrossFade(
          firstCurve: Curves.easeInOut,
          firstChild: ActualTaskList(
            colorTheme: db.colorSchemes,
            themeIndex: db.currentColorScheme,
            taskList: db.taskList,
            removeTask: removeTask,
            checkTask: checkTask,
          ),
          secondChild: FinishedTaskList(
            colorTheme: db.colorSchemes,
            themeIndex: db.currentColorScheme,
            taskList: db.finishedTaskList,
            removeTask: deleteTask,
          ),
          crossFadeState: currentScreen == 0
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300)),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar uma Tarefa',
        backgroundColor: db.colorSchemes[db.currentColorScheme]['defaultColor'],
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => NewTaskDialog(
                onAddTask: addTask,
                colorThemes: db.colorSchemes,
                colorIndex: db.currentColorScheme),
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
          backgroundColor: db.colorSchemes[db.currentColorScheme]['bgColor'],
          buttonBackgroundColor: Colors.transparent,
          color: db.colorSchemes[db.currentColorScheme]['mainColor'],
          animationDuration: const Duration(milliseconds: 300),
          index: currentScreen,
          onTap: (index) {
            changeScreen(index);
          },
          items: [
            Icon(
              Icons.list_alt,
              color: db.colorSchemes[db.currentColorScheme]['iconColor'],
              size: 36,
            ),
            Icon(
              Icons.playlist_add_check,
              color: db.colorSchemes[db.currentColorScheme]['iconColor'],
              size: 42,
            ),
          ]),
    );
  }
}
