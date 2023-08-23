import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/pages/actual_task_list.dart';
import 'package:todo_app/utils/new_task_dialog.dart';
import 'package:todo_app/widgets/empty_list_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentScreen = 0;
  List<TaskModel> taskList = [
    TaskModel(title: 'placeHolder', isCompleted: false)
  ];

  void checkTask(bool? value, int index) {
    setState(() {
      taskList[index].isCompleted = !taskList[index].isCompleted;
      final task = taskList.removeAt(index);
      taskList.add(task);
    });
  }

  void removeTask(TaskModel task) {
    setState(() {
      taskList.remove(task);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Center(
            child: Text(
          currentScreen == 0 ? 'TAREFAS A FAZER' : 'TAREFAS FEITAS',
        )),
        elevation: 0,
      ),
      body: currentScreen == 0
          ? ActualTaskList(
              taskList: taskList,
              removeTask: removeTask,
              checkTask: checkTask,
            )
          : const EmptyListWidget(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar uma Tarefa',
        backgroundColor: Colors.purple,
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
          backgroundColor: const Color.fromRGBO(206, 147, 216, 1),
          buttonBackgroundColor: Colors.transparent,
          color: Colors.deepPurple,
          animationDuration: const Duration(milliseconds: 300),
          index: currentScreen,
          onTap: (index) {
            changeScreen(index);
          },
          items: const [
            Icon(
              Icons.list_alt,
              color: Colors.white,
              size: 36,
            ),
            Icon(
              Icons.check,
              color: Colors.white,
              size: 36,
            ),
          ]),
    );
  }
}
