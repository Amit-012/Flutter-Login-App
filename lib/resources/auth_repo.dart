import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/resources/storage_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';

class Auththentication extends GetxController {
  static Auththentication instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;
  late Rx<User?> _user;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  // Sign up User
  Future<String> signupUser({
    required String fullName,
    required String emailAddress,
    required String passWord,
    required String phoneNumber,
    Uint8List? image,
  }) async {
    String res = 'some error occured';
    try {
      if (fullName.isNotEmpty ||
          emailAddress.isNotEmpty ||
          passWord.isNotEmpty ||
          phoneNumber.isNotEmpty ||
          image != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: emailAddress,
          password: passWord,
        );

        String uid = FirebaseAuth.instance.currentUser!.uid;

        String photoUrl =
            await StorageMethods().uploadImageToStorage('Profile Pic', image!);

        await _database.collection('users').doc(cred.user!.uid).set({
          'full_name': fullName,
          'email': emailAddress,
          'password': passWord,
          'phone_number': phoneNumber,
          'photo_url': photoUrl,
          'uid': uid,
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

  // Reset password
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

  Future<String> updateUser({
    required String fullName,
    required String emailAddress,
    required String passWord,
    required String phoneNumber,
    Uint8List? image,
  }) async {
    String res = 'some error occured';
    try {
      if (fullName.isNotEmpty ||
          emailAddress.isNotEmpty ||
          passWord.isNotEmpty ||
          phoneNumber.isNotEmpty ||
          image != null) {
        String uid = FirebaseAuth.instance.currentUser!.uid;

        String photoUrl =
            await StorageMethods().uploadImageToStorage('Profile Pic', image!);

        await _database.collection('users').doc(uid).update({
          'full_name': fullName,
          'email': emailAddress,
          'password': passWord,
          'phone_number': phoneNumber,
          'photo_url': photoUrl,
          'uid': uid,
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
}
