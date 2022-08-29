import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selftable_task/modules/auth/auth_controller.dart';
class SplashScreen extends StatelessWidget {
   SplashScreen({Key? key}) : super(key: key);

  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator(),)

    );
  }
}
