import 'package:get/get.dart';
import 'package:selftable_task/modules/auth/login/login_screen.dart';
import 'package:selftable_task/modules/auth/signup/signup_screen.dart';
import 'package:selftable_task/modules/home_tabbar/home_tabbar_screen.dart';
import 'package:selftable_task/modules/splash/splash_screen.dart';
import 'package:selftable_task/routes/bindings.dart';
import 'package:selftable_task/routes/route_constants.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: RoutesConstants.splashScreen,
      page: () =>  SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RoutesConstants.signUpScreen,
      page: () =>  SignUpScreen(),
      binding: SignUpBinding(),
      transition: Transition.fade,
    ),

    GetPage(
      name: RoutesConstants.loginScreen,
      page: () =>  LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RoutesConstants.homeTabBarScreen,
      page: () =>  HomeTabBarScreen(),
      binding: HomeTabBarBinding(),
      transition: Transition.fade,
    ),
  ];
}
