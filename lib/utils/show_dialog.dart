//these functions are called when the user will add a new todo , a alert dialog  gets popped up

import 'package:flutter/material.dart';
import 'package:todo_app/utils/constant.dart';
import 'package:todo_app/utils/textStyle.dart';

Future<void> addDialog(BuildContext context,
    TextEditingController titleController, VoidCallback onPressed, bool isNew) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            actions: [
              //text button to add up finally
              TextButton(
                  onPressed: onPressed,
                  child: Text(
                    (isNew) ? 'Add' : 'Save',
                    style: textStyle(15, Utils.black, FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () {
                    titleController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: textStyle(15, Utils.black, FontWeight.bold),
                  )),
            ],
            title: Text(
              'Add a new ToDo',
              style: textStyle(15, Utils.pink, FontWeight.bold),
            ),
            backgroundColor: Utils.white,
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: TextField(
                maxLength: null,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                style: textStyle(12, Utils.black, FontWeight.w300),
                controller: titleController,
                decoration: InputDecoration(
                    hintText: 'enter a new todo',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
          ));
}
