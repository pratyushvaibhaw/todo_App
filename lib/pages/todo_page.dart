import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/Boxes/boxes.dart';
import 'package:todo_app/add_button.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/utils/show_dialog.dart';
import 'package:todo_app/utils/textStyle.dart';
import 'package:todo_app/widgets/noTodo.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          actions: [
            //button for addding a new todo
            AddButton(
              onTap: () {
                addnewTodo();
              },
            ),
          ],
          title: Text(
            'Your todos',
            style: textStyle(35, AppColor.white, FontWeight.bold),
          ),
        ),
        backgroundColor: AppColor.black,
        //valuelistenable builder fetches the change/updation which is notified by the Hive , thus we don't need update the state explicitly
        body: ValueListenableBuilder(
            valueListenable: Boxes.getData().listenable(),
            builder: (context, box, _) {
              //casting the fetched box data back to our todo model type
              var data = box.values.toList().cast<TodoModel>();
              return (box.length !=
                      0) // incase user has no task , then alternatively notdo widget is called
                  ? ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: box.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          height: 90,
                          child: ListTile(
                            splashColor: AppColor.blue,
                            //longpressing a tile will automatically delete it
                            onLongPress: () => deleteTodo(data[index]),
                            trailing: SizedBox(
                              height: 20,
                              width: 20,
                              child: GestureDetector(
                                onTap: () {
                                  markDone(data[index]);
                                },
                                child: CircleAvatar(
                                  // if the task is undone it is white , gets marked for done on tapping
                                  backgroundColor: (data[index].isCompleted)
                                      ? AppColor.green
                                      : AppColor.white,
                                  child: (data[index].isCompleted)
                                      ? Icon(
                                          Icons.done_sharp,
                                          color: AppColor.white,
                                          size: 18,
                                          weight: 5,
                                        )
                                      : Container(),
                                ),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: AppColor.pink,
                            title: Text(
                              data[index].title,
                              style: textStyle(
                                  15, AppColor.white, FontWeight.bold),
                            ),
                          ),
                        );
                      }))
                  : const NoTodo(); //notodo widget
            }),
      ),
    );
  }

  // funtion to add data , calls the addDialog
  addnewTodo() {
    addDialog(context, titleController, () {
      final data = TodoModel(title: titleController.text);
      final box = Boxes.getData(); //Boxes object
      box.add(data); //adding data to box
      debugPrint(box.toString());
      titleController.clear();
      Navigator.pop(context);
    });
  }

  //deleting the selected todo
  void deleteTodo(TodoModel todoModel) async {
    await todoModel.delete();
  }

  //marking the task done
  void markDone(TodoModel todoModel) {
    todoModel.isCompleted = !todoModel.isCompleted;
    todoModel.save();
  }
}
