import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selftable_task/routes/route_constants.dart';
import 'package:selftable_task/routes/router.dart';
import 'package:selftable_task/ui_helpers/app_theme_data.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SelfTable Task',
      theme: AppThemeData.appTheme,
      getPages: AppRouter.routes,
      initialRoute: RoutesConstants.splashScreen,

    );
  }
}
