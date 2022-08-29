
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:selftable_task/models/user_model.dart';

import 'package:selftable_task/routes/route_constants.dart';

class AuthController extends GetxController {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();



  @override
  void onInit() async {
    //run every time auth state changes
   ever(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(user);



    super.onInit();
  }



  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    print('handleAuthChanged');
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
    }

    if (_firebaseUser == null) {
      print('Send to signin');
      Get.offAndToNamed(RoutesConstants.signUpScreen);
    } else {
      Get.offAndToNamed(RoutesConstants.homeTabBarScreen);
    }
  }

  // Firebase user one-time fetch
  Future<User> get getUser async => auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => auth.authStateChanges();

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return db
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));

  }

  //get the firestore user from the firestore collection
  Future<UserModel> getFirestoreUser() async{
    var currentUser = auth.currentUser!;
    return db.doc('/users/${currentUser.uid}').get().then(
            (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  }

  // Sign out
  Future<void> signOut() {

    return auth.signOut();
  }
}