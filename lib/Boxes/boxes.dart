import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';
//this class is used to get the boxes (hive objects back from the local storage)
class Boxes {
  static Box<TodoModel> getData() => Hive.box<TodoModel>('todos');
}
