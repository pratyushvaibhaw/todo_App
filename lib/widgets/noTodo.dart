import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/utils/constant.dart';
import 'package:todo_app/utils/textStyle.dart';
import 'package:velocity_x/velocity_x.dart';

class NoTodo extends StatelessWidget {
  const NoTodo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideInDown(
            child: Image.asset(
              'assets/images/todo.png',
              height: 200,
              width: 200,
            ),
          ),
          10.heightBox,
          ZoomIn(
            duration: const Duration(milliseconds: 500),
            child: Text(
              'No tasks added yet !!',
              style: textStyle(20, Utils.white, FontWeight.w500),
            ),
          ),
          50.heightBox,
          // Text(
          //   'Tap the + button to add a new task',
          //   style: textStyle(12, Utils.white, FontWeight.w300),
          // ),
          // 8.heightBox,
          // Text(
          //   'To delete a task, long press its tile',
          //   style: textStyle(12, Utils.white, FontWeight.w300),
          // ),
        ],
      ),
    );
  }
}
