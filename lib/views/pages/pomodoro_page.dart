import 'package:flutter/material.dart';
import 'package:todo_app/utils/constant.dart';
import 'package:todo_app/utils/textStyle.dart';

class PomoDoroPage extends StatefulWidget {
  const PomoDoroPage({super.key});

  @override
  State<PomoDoroPage> createState() => _PomoDoroPageState();
}

class _PomoDoroPageState extends State<PomoDoroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Text(
            'Pomodoro Timer',
            style: textStyle(20, Utils.yellow, FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
