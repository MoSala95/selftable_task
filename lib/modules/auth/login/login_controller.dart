import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selftable_task/globals/global_enums.dart';
import 'package:selftable_task/models/auth_fields_validation_models/fields_objects.dart';
import 'package:selftable_task/modules/auth/auth_controller.dart';

class LoginController extends GetxController{

  late Email email;
  late LoginPassword password;
  bool isPassHidden = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  LoadingState loadingState = LoadingState.done;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void showPassword() {
    isPassHidden = !isPassHidden;
    update();
  }
  validateForm(){
    if(loginFormKey.currentState!.validate()){
      print("form is valid");
      signInWithEmailAndPassword();
    }

  }
//Method to handle user sign in using email and password
signInWithEmailAndPassword() async {
  loadingState = LoadingState.waiting;
  update();
  try {
    await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    emailController.clear();
    passwordController.clear();
    loadingState = LoadingState.done;
    update();
  } on FirebaseAuthException catch (error) {
    loadingState = LoadingState.done;
    update();
    Get.snackbar("Login Error", error.message!,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      colorText: Colors.black
    );
  }
}

}