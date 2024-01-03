import 'package:flutter/material.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/utils/textStyle.dart';
import 'package:todo_app/services/splash_services.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.changePage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.black,
        body: Center(
          child: Text(
            'ToDo App',
            style: textStyle(45, AppColor.pink, FontWeight.bold),
          ),
        ));
  }
}
