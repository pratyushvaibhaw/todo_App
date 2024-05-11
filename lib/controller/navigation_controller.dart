import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  int pageIndex = 0;
  int get index => pageIndex;
  final pageController = PageController();
  void updateIndex(int val) {
    pageIndex = val;
  }
}
