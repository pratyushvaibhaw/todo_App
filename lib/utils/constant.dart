import 'package:flutter/material.dart';
import 'package:todo_app/views/pages/addtodo__page.dart';
import 'package:todo_app/views/pages/pomodoro_page.dart';
import 'package:todo_app/views/pages/todo_page.dart';

class Utils {
  static Color pink = Colors.pinkAccent.shade400;
  static Color yellow = Colors.yellowAccent.shade400;
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color blue = Colors.blueAccent.shade200;
  static Color green = Colors.greenAccent.shade700;

  static List<String> tabname = ['ToDos', 'PomoDoro'];
  static List<Widget> tabs = [const AddToDoPage(), const PomoDoroPage()];
}
