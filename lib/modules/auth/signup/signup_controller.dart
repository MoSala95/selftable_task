import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selftable_task/globals/global_enums.dart';
import 'package:selftable_task/models/auth_fields_validation_models/fields_objects.dart';
import 'package:selftable_task/models/user_model.dart';
import 'package:selftable_task/modules/auth/auth_controller.dart';
import 'package:selftable_task/modules/image_picker/image_picker_functions.dart';
import 'package:selftable_task/modules/image_picker/image_picker_mixin_controller.dart';

class SignUpController extends GetxController with ImagePickerMixinController{

  late Name name;
  late Age age;
  late Email email;
  late SignUpPassword password;
  bool isPassHidden = true;

  String profileImageUrl= "";

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  bool isProfilePictureChanged = false;

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
    if(signUpFormKey.currentState!.validate()){
      print("form is valid");
      registerWithEmailAndPassword();
    }

  }
  // User registration using email and password
  registerWithEmailAndPassword() async {
     loadingState = LoadingState.waiting;
    update();
    await uploadProfileImgTOFirebase();
    try {
      await auth
          .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text)
          .then((result) async {
        print('uID: ' + result.user!.uid.toString());
        print('email: ' + result.user!.email.toString());

        //create the new user object
        UserModel _newUser = UserModel(
            uid: result.user!.uid,
            email: result.user!.email!,
            name: nameController.text,
            age: ageController.text,
            photoUrl: profileImageUrl
        );
        //create the user in firestore
        _createUserFirestore(_newUser, result.user!);
        emailController.clear();
        passwordController.clear();
        // hideLoadingIndicator();
      });
      loadingState = LoadingState.done;
    } on FirebaseAuthException catch (error) {
      loadingState = LoadingState.done;
      update();
      Get.snackbar("Error while trying to singUp", error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),);
    }
  }

  //create the firestore user in users collection
  void _createUserFirestore(UserModel user, User _firebaseUser) {
    db.doc('/users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }
  void addNewProfileImage() async {

    ImagePickerFunctions.openImagePicker(onGetImage: (XFile imageFile) async {
      pikedImageFile = imageFile;
      var imageSize = await pikedImageFile!.readAsBytes();
      if (imageSize.length <= 10000048) {
        isProfilePictureChanged = true;
      } else {
        //maxImageSizeError
        pikedImageFile = null;
      }
      update();
    }, onGetError: (e) {
      print("error in openImagePicker: ${e.toString()}");
    });
   }

   Future<void> uploadProfileImgTOFirebase() async{
    if(pikedImageFile==null) {
      return;
    }
    final img = File(pikedImageFile!.path);
     final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
     final firebaseStorageRef = FirebaseStorage.instance
         .ref()
         .child('images/$imageName');
     UploadTask uploadTask = firebaseStorageRef.putFile(img);
     await uploadTask.whenComplete(() async {
       var url = await firebaseStorageRef.getDownloadURL();
       profileImageUrl = url.toString();
     }).catchError((onError) {
       print(onError);
     });
   }


}