//separate class responsible for loading the todopage after a timer delay
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_app/views/navigation_wrapper.dart';

class SplashServices {
  changePage(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NavigationWrapper()));
    });
  }
}
