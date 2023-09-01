import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task_model.dart';

class ToDoDataBase {
  List<dynamic> taskList = [];
  List<dynamic> finishedTaskList = [];
  final List<Map> colorSchemes = [
    {
      'themeName': 'Inverno Roxo',
      'themeIcon': Icons.ac_unit,
      'bgColor': Colors.purple[200],
      'dialogColor': Colors.purple[100],
      'defaultColor': Colors.purple,
      'mainColor': Colors.deepPurple,
      'cardTextColor': Colors.white,
      'titleColor': Colors.white,
      'iconColor': Colors.white,
      'finishedColor': Colors.purple[700]
    },
    {
      'themeName': 'Brisa de Verão',
      'themeIcon': Icons.air_rounded,
      'bgColor': Colors.yellow[200],
      'dialogColor': Colors.yellow[100],
      'defaultColor': Colors.orange,
      'mainColor': Colors.deepOrange,
      'cardTextColor': Colors.white,
      'titleColor': Colors.black,
      'iconColor': Colors.black,
      'finishedColor': const Color.fromARGB(255, 177, 120, 45)
    },
    {
      'themeName': 'Morango Gelado',
      'themeIcon': Icons.icecream_rounded,
      'bgColor': Colors.red[200],
      'dialogColor': Colors.red[100],
      'defaultColor': Colors.red[700],
      'mainColor': Colors.red,
      'cardTextColor': Colors.white,
      'titleColor': Colors.white,
      'iconColor': Colors.white,
      'finishedColor': const Color.fromARGB(255, 104, 30, 30)
    },
    {
      'themeName': 'Bosque Mágico',
      'themeIcon': Icons.forest_rounded,
      'bgColor': Colors.green[200],
      'dialogColor': Colors.green[100],
      'defaultColor': Colors.green[700],
      'mainColor': Colors.green,
      'cardTextColor': Colors.white,
      'titleColor': Colors.white,
      'iconColor': Colors.white,
      'finishedColor': Color.fromARGB(255, 14, 54, 4)
    },
    {
      'themeName': 'Alto Mar',
      'themeIcon': Icons.sailing,
      'bgColor': Colors.blue[200],
      'dialogColor': Colors.blue[100],
      'defaultColor': Colors.blue[700],
      'mainColor': Colors.blue,
      'cardTextColor': Colors.white,
      'titleColor': Colors.white,
      'iconColor': Colors.white,
      'finishedColor': Color.fromARGB(255, 11, 20, 141)
    },
    {
      'themeName': 'Chocolate Quente',
      'themeIcon': Icons.local_cafe,
      'bgColor': Colors.brown[200],
      'dialogColor': Colors.brown[100],
      'defaultColor': Colors.brown[700],
      'mainColor': Colors.brown,
      'cardTextColor': Colors.white,
      'titleColor': Colors.white,
      'iconColor': Colors.white,
      'finishedColor': Color.fromARGB(255, 110, 55, 4)
    },
    {
      'themeName': 'Noite de Luar',
      'themeIcon': Icons.nights_stay,
      'bgColor': Colors.grey[600],
      'dialogColor': Colors.grey[200],
      'defaultColor': Colors.grey[700],
      'mainColor': Colors.grey[500],
      'cardTextColor': Colors.black,
      'titleColor': Colors.white,
      'iconColor': Colors.black,
      'finishedColor': Color.fromARGB(255, 160, 155, 153)
    },
  ];
  var currentColorScheme = 0;

  //reference the hive box
  final _dataBox = Hive.box('dataBox');

  void createInitialData() {
    taskList = [
      TaskModel(
          title: 'Arraste para a direita para marcar tarefas como concluídas',
          isCompleted: false),
      TaskModel(
          title: 'Arraste para a esquerda para deletar tarefas',
          isCompleted: false),
      TaskModel(
          title: 'Use os botões abaixo para navegar entre as listas',
          isCompleted: false),
      TaskModel(
          title:
              'Use o botão no canto superior para escolher o seu tema preferido',
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
