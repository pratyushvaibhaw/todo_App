//separate class responsible for loading the todopage after a timer delay
import 'dart:async';
import 'package:flutter/material.dart';

class SplashServices {
  changePage(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, 'todo');
    });
  }
}
