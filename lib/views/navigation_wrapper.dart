import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:todo_app/controller/navigation_controller.dart';
import 'package:todo_app/utils/constant.dart';
import 'package:todo_app/utils/textStyle.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper>
    with TickerProviderStateMixin {
  final navController = Get.find<NavigationController>();
  MotionTabBarController? _tabBarController;
  @override
  void initState() {
    _tabBarController = MotionTabBarController(
      length: Utils.tabs.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: MotionTabBar(
          textStyle: textStyle(14, Colors.black, FontWeight.bold),
          tabIconColor: Utils.pink,
          tabBarColor: Colors.white,
          tabSelectedColor: Utils.blue,
          tabBarHeight: 50,
          tabSize: 40,
          controller: _tabBarController,
          icons: const [Icons.list_alt_rounded, Icons.timer],
          initialSelectedTab: Utils.tabname[0],
          labels: Utils.tabname,
          onTabItemSelected: (int v) {
            navController.updateIndex(v);
            navController.pageController.jumpToPage(v);
            _tabBarController!.index = v;
          },
        ),
        body: PageView(
          controller: navController.pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (v) {
            navController.updateIndex(v);
            navController.pageController.jumpToPage(v);
            _tabBarController!.index = v;
          },
          children: Utils.tabs,
        ),
      ),
    );
  }
}
