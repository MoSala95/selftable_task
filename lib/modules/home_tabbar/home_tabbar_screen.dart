import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:selftable_task/modules/home_tabbar/home_tabbar_controller.dart';
import 'package:selftable_task/ui_helpers/assets_constants.dart';
import 'package:selftable_task/ui_helpers/color_constants.dart';

class HomeTabBarScreen extends StatelessWidget {
    HomeTabBarScreen({Key? key}) : super(key: key);

  final homeTabController= Get.find<HomeTabBarController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeTabBarController>(
        builder: (_) {
      return Scaffold(
        backgroundColor: Colors.white,
        body:homeTabController.getCurrentPage(),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              gradient: LinearGradient(
                colors: [Color(0xffffffff), Color(0xfffbe9e7)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )

          ),

          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            selectedItemColor: ColorConstants.primaryColor,
            unselectedItemColor: Colors.black,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            unselectedFontSize: 12,

            type: BottomNavigationBarType.fixed,
            elevation: 0,

            onTap:homeTabController.onTabSelected,
            currentIndex: homeTabController.currentTabIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: "Cats",
                icon: Column(
                  children: [

                    SvgPicture.asset(
                        AssetsConstants.notActiveCatsIcon,
                        fit: BoxFit.fill),
                    const SizedBox(height: 10,)
                  ],
                ),
                activeIcon: Column(
                  children: [
                    SvgPicture.asset(AssetsConstants.activeCatsIcon,
                        fit: BoxFit.fill),
                    const SizedBox(height: 10,)
                  ],
                ),
              ),
              BottomNavigationBarItem(
                label: "Me",

                icon: Column(
                  children: [
                    SvgPicture.asset(
                        AssetsConstants.notActiveProfileIcon,
                        fit: BoxFit.fill),
                    const SizedBox(height: 10,)
                  ],
                ),
                activeIcon: Column(
                  children: [
                    SvgPicture.asset(
                        AssetsConstants.activeProfileIcon,
                        fit: BoxFit.fill),
                    const SizedBox(height: 10,)
                  ],
                ),
              ),

            ],
          ),
        ),
      );
    });
  }
}
