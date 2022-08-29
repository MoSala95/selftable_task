import 'package:get/get.dart';
import 'package:selftable_task/modules/auth/auth_controller.dart';
import 'package:selftable_task/modules/auth/login/login_controller.dart';
import 'package:selftable_task/modules/auth/login/login_screen.dart';
import 'package:selftable_task/modules/auth/signup/signup_controller.dart';
import 'package:selftable_task/modules/cats/cats_controller.dart';
import 'package:selftable_task/modules/home_tabbar/home_tabbar_controller.dart';
import 'package:selftable_task/modules/profile/profile_controller.dart';


class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(),permanent: true);
  }
}
class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class HomeTabBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeTabBarController());
    Get.lazyPut(() => CatsController());
    Get.lazyPut(() => ProfileController());

  }
}