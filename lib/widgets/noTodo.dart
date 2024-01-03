import 'package:flutter/material.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/utils/textStyle.dart';

class NoTodo extends StatelessWidget {
  const NoTodo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/todo.png',
            ),
            Text(
              'Add a new task',
              style: textStyle(15, AppColor.white, FontWeight.w300),
            ),
          ],
        ),
        const SizedBox(
          height: 75,
        ),
        Text(
          'To delete long press the corresponding tile',
          style: textStyle(10, AppColor.white, FontWeight.w300),
        ),
      ],
    );
  }
}
