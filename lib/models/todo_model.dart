//this class describes the basic structure of a todo as a Hive Object
import 'package:hive/hive.dart';
part 'todo_model.g.dart'; //contains mappings between the model class and hive entities

@HiveType(typeId: 0) //id assigned to this model
class TodoModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  bool isCompleted;

  TodoModel({required this.title, this.isCompleted = false});
}
