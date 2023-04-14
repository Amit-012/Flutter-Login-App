// // ignore_for_file: avoid_print

// import 'package:demoapp/pages/home_page.dart';
// import 'package:demoapp/pages/login_page.dart';
// import 'package:flutter/material.dart';
// import '../../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Auththentication extends GetxController {
  static Auththentication instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;
  // late Rx<User?> _user;

  // @override
  // void onReady() {
  //   super.onReady();
  //   _user = Rx<User?>(_auth.currentUser);
  //   _user.bindStream(_auth.userChanges());
  //   ever(_user, _initialScreen);
  // }

  // _initialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAll(() => const LoginPage());
  //   } else {
  //     Get.offAll(() => HomePage());
  //   }
  // }

  // Sign up User
  Future<String> signupUser({
    required String fullName,
    required String emailAddress,
    required String passWord,
    required String phoneNumber,
  }) async {
    String res = 'some error occured';
    try {
      if (fullName.isNotEmpty ||
          emailAddress.isNotEmpty ||
          passWord.isNotEmpty ||
          phoneNumber.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: emailAddress,
          password: passWord,
        );

        await _database.collection('users').doc(cred.user!.uid).set({
          'full_name': fullName,
          'email': emailAddress,
          'password': passWord,
          'phone_number': phoneNumber,
        });
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
  // login user

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'some error occured';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> resetPassword({required String email}) async {
    String res = 'some error occured';

    try {
      if (email.isNotEmpty) {
        await _auth.sendPasswordResetEmail(
          email: email,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
  // Sign Out User

  Future<void> signOutUser() async {
    await _auth.signOut();
  }
}
