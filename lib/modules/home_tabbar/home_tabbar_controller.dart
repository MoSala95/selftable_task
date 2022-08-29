import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selftable_task/modules/cats/cats_screen.dart';
import 'package:selftable_task/modules/profile/profile_screen.dart';

class HomeTabBarController extends GetxController{


  int currentTabIndex = 0;

  List pages = [CatsScreen(),ProfileScreen()];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  onTabSelected(int val){
    currentTabIndex = val;
    update();
  }

  Widget getCurrentPage(){
    return pages[currentTabIndex];
  }

}