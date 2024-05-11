import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/Boxes/boxes.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/pages/views/todo_page.dart';
import 'package:todo_app/utils/constant.dart';
import 'package:todo_app/utils/show_dialog.dart';
import 'package:todo_app/utils/textStyle.dart';
import 'package:todo_app/widgets/add_button.dart';
import 'package:todo_app/widgets/noTodo.dart';

class AddToDoPage extends StatefulWidget {
  const AddToDoPage({super.key});

  @override
  State<AddToDoPage> createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  final titleController = TextEditingController();
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // for (int i = 30; i <= 60; i++) {
    //   Boxes.getData().add(TodoModel(title: 'Test ToDo $i'));
    // }
    return Scaffold(
      backgroundColor: Utils.black,
      //valuelistenable builder fetches the change/updation which is notified by the Hive , thus we don't need update the state explicitly
      body: ValueListenableBuilder(
          valueListenable: (Boxes.getData().listenable()),
          builder: (context, box, _) {
            //casting the fetched box data back to our todo model type
            var data = box.values.toList().cast<TodoModel>().reversed.toList();
            return CustomScrollView(physics: ClampingScrollPhysics(), slivers: [
              appBar(),
              (box.length != 0)
                  ? SliverList.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          // height: 90,
                          child: GestureDetector(
                            onDoubleTap: () => deleteTodo(data[index]),
                            child: ListTile(
                              // splashColor: Utils.blue,
                              //longpressing a tile will open editing window
                              onLongPress: () {
                                titleController.text = data[index].title;
                                editTodo(box.length - index - 1);
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
                      },
                      itemCount: box.length,
                    )
                  : const SliverFillRemaining(
                      hasScrollBody: false, child: NoTodo()),
            ]);
          }),
    );
  }

  SliverAppBar appBar() {
    return SliverAppBar(
      elevation: 0,
      pinned: false,
      snap: true,
      floating: true,
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
