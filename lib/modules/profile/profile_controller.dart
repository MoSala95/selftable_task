import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:selftable_task/globals/global_enums.dart';
import 'package:selftable_task/models/cat_model.dart';
import 'package:selftable_task/models/user_model.dart';
import 'package:selftable_task/modules/auth/auth_controller.dart';

class ProfileController extends GetxController{

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  UserModel? userModel;
  LoadingState loadingState = LoadingState.done;

  List<CatModel> favoriteCats = [];
  final authController = Get.find<AuthController>();

@override
  void onInit()async {
    // TODO: implement onInit
   userModel = await authController.getFirestoreUser();
   authController.firestoreUser.listen((newVal) {
    userModel=newVal;
    getMyCats();
   });
// await getMyCats();
    super.onInit();
  }

  Future<void>getMyCats()async{
    favoriteCats.clear();
  for(var fav in userModel!.favoriteList){

    fav as Map<String,dynamic>;
    String collectionId= fav.keys.first;
    String docId= fav.values.first;

    try {
      DocumentSnapshot docSnapshot = await db.collection(collectionId).doc(docId).get();
      favoriteCats.add(CatModel.fromMap(docSnapshot.data() as Map<String, dynamic>));


    }on FirebaseException catch(error){
      loadingState=LoadingState.waiting;
      update();
      print(error.message);
    };

  }
  update();
  }
  onRemoveCat({required CatModel catModel}) {
    List favoriteList = [];
    favoriteList.addAll(userModel!.favoriteList);
    favoriteList.forEach((element) {
      userModel!.favoriteList
          .removeWhere((element) => mapEquals(catModel.id, element));
    });
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(authController.firebaseUser.value!.uid)
          .update({
        "favoriteList": userModel!.favoriteList
      });

      update();
    } on FirebaseException catch (error) {
      print(error.message);
      Get.snackbar(
        "Error ",
        error.message!,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    }
    update();
  }

}