import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:selftable_task/globals/global_enums.dart';
import 'package:selftable_task/models/cat_model.dart';
import 'package:selftable_task/modules/auth/auth_controller.dart';

class CatsController extends GetxController {
  LoadingState loadingState = LoadingState.done;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<CatModel> allCats = [];
  List<CatModel> featuredCats = [];

  final authController = Get.find<AuthController>();

  @override
  void onInit() async {
    print("is cats user null "+"${authController.firestoreUser.value==null}");

    await getAllCats();
    await getFeaturedCats();

    authController.firestoreUser.listen((p0) {
      update();
    });

    super.onInit();
  }

  Future<void> getAllCats() async {
    loadingState=LoadingState.waiting;
    update();
    try {
      QuerySnapshot querySnapshot = await db.collection('allcats').get().catchError((_){
        loadingState=LoadingState.waiting;
        update();

      });
      // Get data from docs and convert map to List
      querySnapshot.docs.forEach((element) {
        print(element.data());
        allCats.add(CatModel.fromMap(element.data() as Map<String, dynamic>));
      });
      loadingState=LoadingState.done;
      update();
    }on FirebaseException catch(error){
      loadingState=LoadingState.waiting;
      update();
      print(error.message);
    };
    update();
  }

  Future<void> getFeaturedCats() async {
    QuerySnapshot querySnapshot = await db.collection('featuredcat').get();

    // Get data from docs and convert map to List
    querySnapshot.docs.forEach((element) {
      print(element.data());
      featuredCats
          .add(CatModel.fromMap(element.data() as Map<String, dynamic>));
    });
    update();
  }

  onAddCat({required CatModel catModel}) {
    print("add new cat");
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(authController.firebaseUser.value!.uid)
          .update({
        "favoriteList": FieldValue.arrayUnion([catModel.id])
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
  }

  onRemoveCat({required CatModel catModel}) {
    List favoriteList = [];
    favoriteList.addAll(authController.firestoreUser.value!.favoriteList);
    favoriteList.forEach((element) {
      authController.firestoreUser.value!.favoriteList
          .removeWhere((element) => mapEquals(catModel.id, element));
    });
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(authController.firebaseUser.value!.uid)
          .update({
        "favoriteList": authController.firestoreUser.value!.favoriteList
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

  bool checkIfInFavList({required CatModel catModel}) {
    final catId = catModel.id;
    for (var favItem in authController.firestoreUser.value!.favoriteList) {
      if (mapEquals(catId, favItem)) {
        return true;
      }
    }
    return false;
  }
}
