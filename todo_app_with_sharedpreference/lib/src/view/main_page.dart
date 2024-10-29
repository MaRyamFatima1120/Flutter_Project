import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todo_app_with_sharedpreference/common/constants/global_variable.dart';
import 'package:todo_app_with_sharedpreference/src/view/home/home_page.dart';

import '../../common/constants/app_icon.dart';
import '../view-model/main_controller.dart';
import 'home/task_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainController controller=Get.put(MainController());

  final List<Widget> _pages =[
    const Homepage(),
    const TaskView(),
    const Center(child: Text("Inbox Page"),),
    const Center(child: Text("Profile Page"),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx(()=>_pages[controller.selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          backgroundColor: colorScheme(context).secondary,
          currentIndex: controller.selectedIndex,
          unselectedItemColor:colorScheme(context).onSecondary,
          selectedItemColor: colorScheme(context).onSecondary,
          onTap: controller.onItemTap,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcon.homeIcon,
                  width: 20,
                  height: 20,
                ), label: "Home"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcon.workIcon,
                  width: 20,
                  height: 20,
                ), label: "Task"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcon.profileIcon,
                  width: 20,
                  height: 20,
                ), label: "Profile"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcon.settingIcon,
                  width: 20,
                  height: 20,
                ), label: "Setting"),
          ]),
    );
  }
}
