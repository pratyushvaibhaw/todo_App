import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/controller/navigation_controller.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/views/pages/todo_page.dart';

import 'package:todo_app/utils/constant.dart';
import 'package:todo_app/views/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var directory =
      await getApplicationDocumentsDirectory(); //provides directory to store the persistent data
  Hive.init(directory.path);
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>(
      'todos'); //creating a file of type TodoModel in local storage
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Utils.black, elevation: 0),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const SplashPage(),
        'todo': (context) => const ToDoPage()
      },
      initialRoute: '/',
    );
  }
}
