import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/Boxes/boxes.dart';
import 'package:todo_app/widgets/add_button.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/utils/constant.dart';
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
  final _scrollController = ScrollController();
  bool _isAppBarVisible = true;
  bool _isScrollingDown = true;
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isScrollingDown) {
          _isScrollingDown = false;
          _isAppBarVisible = false;
          setState(() {});
        }
      } else {
        _isScrollingDown = true;
        _isAppBarVisible = true;
        setState(() {});
      }
    });
    return SafeArea(
      child: Scaffold(
        appBar: (_isAppBarVisible) // put the check here
            ? appBar() // method returning app bar
            : null,
        backgroundColor: Utils.black,
        //valuelistenable builder fetches the change/updation which is notified by the Hive , thus we don't need update the state explicitly
        body: ValueListenableBuilder(
            valueListenable: Boxes.getData().listenable(),
            builder: (context, box, _) {
              //casting the fetched box data back to our todo model type
              var data = box.values.toList().cast<TodoModel>();
              return (box.length !=
                      0) // incase user has no task , then alternatively notdo widget is called
                  ? ListView.builder(
                      controller:
                          _scrollController, // finally attach the scroll controller to your scrollable widget
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: box.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          // height: 90,
                          child: GestureDetector(
                            onDoubleTap: () => deleteTodo(data[index]),
                            child: ListTile(
                              splashColor: Utils.blue,
                              //longpressing a tile will open editing window
                              onLongPress: () {
                                titleController.text = data[index].title;
                                editTodo(index);
                              },

                              trailing: SizedBox(
                                height: 17,
                                width: 17,
                                child: GestureDetector(
                                  onTap: () {
                                    markDone(data[index]);
                                  },
                                  child: CircleAvatar(
                                    // if the task is undone it is white , gets marked for done on tapping
                                    backgroundColor: (data[index].isCompleted)
                                        ? Utils.green
                                        : Utils.white,
                                    child: (data[index].isCompleted)
                                        ? Icon(
                                            Icons.done_sharp,
                                            color: Utils.white,
                                            size: 15,
                                            weight: 20,
                                          )
                                        : Container(),
                                  ),
                                ),
                              ),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(6))),
                              tileColor: Utils.pink,
                              title: Text(
                                data[index].title,
                                style:
                                    textStyle(15, Utils.white, FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      }))
                  : const NoTodo(); //notodo widget
            }),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Utils.black,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12))),
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
        style: textStyle(35, Utils.white, FontWeight.bold),
      ),
    );
  }

  // funtion to add data , calls the addDialog
  addnewTodo() {
    addDialog(context, titleController, () {
      if (titleController.text.isNotEmpty) {
        final data = TodoModel(title: titleController.text);
        final box = Boxes.getData(); //Boxes object
        box.add(data); //adding data to box
        debugPrint(box.toString());
        titleController.clear();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Utils.pink,
            duration: const Duration(seconds: 2),
            content: Text(
              'Please enter a task',
              style: textStyle(15, Utils.white, FontWeight.bold),
            )));
      }
    }, true);
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

  //editing the already created todo
  void editTodo(
    int index,
  ) {
    addDialog(context, titleController, () {
      final box = Boxes.getData();
      final data = TodoModel(title: titleController.text);
      box.putAt(index, data);
      titleController.clear();
      debugPrint(box.toString());
      Navigator.pop(context);
    }, false);
  }
}
