import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task_model.dart';

class ToDoDataBase {
  List<dynamic> taskList = [];
  List<dynamic> finishedTaskList = [];
  final List<Map> colorSchemes = [
    {
      'themeName': 'Roxo',
      'bgColor': Colors.purple[200],
      'defaultColor': Colors.purple,
      'mainColor': Colors.deepPurple,
      'cardTextColor': Colors.white,
      'titleColor': Colors.white,
      'iconColor': Colors.white,
      'finishedColor': Colors.purple[700]
    },
    {
      'themeName': 'Amarelo',
      'bgColor': Colors.yellow[200],
      'defaultColor': Colors.orange,
      'mainColor': Colors.deepOrange,
      'cardTextColor': Colors.white,
      'titleColor': Colors.black,
      'iconColor': Colors.black,
      'finishedColor': const Color.fromARGB(255, 177, 120, 45)
    },
    {
      'themeName': 'Vermelho',
      'bgColor': Colors.red[200],
      'defaultColor': Colors.red[700],
      'mainColor': Colors.red,
      'cardTextColor': Colors.white,
      'titleColor': Colors.black,
      'iconColor': Colors.white,
      'finishedColor': const Color.fromARGB(255, 104, 30, 30)
    },
  ];
  var currentColorScheme = 0;

  //reference the hive box
  final _dataBox = Hive.box('dataBox');

  void createInitialData() {
    taskList = [
      TaskModel(
          title:
              'Toque no checkbox ou arraste para a direita para marcar tarefas como concluídas',
          isCompleted: false),
      TaskModel(
          title: 'Arraste para a esquerda para deletar tarefas',
          isCompleted: false),
    ];
    finishedTaskList = [
      TaskModel(
          title:
              'Suas tarefas completas aparecerão aqui, arraste pra qualquer lado para deletar uma tarefa completa',
          isCompleted: true)
    ];
    currentColorScheme = 0;
  }

  void loadData() {
    taskList = _dataBox.get("TASKLIST");
    finishedTaskList = _dataBox.get("FINISHEDTASKLIST");
    currentColorScheme = _dataBox.get("CURRENTCOLORS");
  }

  void updateData() {
    _dataBox.put("TASKLIST", taskList);
    _dataBox.put("FINISHEDTASKLIST", finishedTaskList);
    _dataBox.put("CURRENTCOLORS", currentColorScheme);
  }
}
