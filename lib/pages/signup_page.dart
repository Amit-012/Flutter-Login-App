// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:demoapp/resources/auth_repo.dart';
import 'package:demoapp/pages/home_page.dart';
import 'package:demoapp/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool changeButton = false;

  Uint8List? image;

  // method: pick image
  void selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.to(() => HomePage()),
                    icon: const Icon(Icons.close),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    'Signup to',
                    style: TextStyle(fontSize: 28, color: Colors.black),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/uoilogo.png'),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: selectImage,
                child: Container(
                  height: 70,
                  width: 70,
                  child: Stack(
                    children: [
                      image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(image: MemoryImage(image!)),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                  image: NetworkImage(
                                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png')),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.add_a_photo,
                            color: Theme.of(context).canvasColor,
                            size: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      MyTextFormField(
                        controller: fullNameController,
                        icon: Icon(
                          Icons.person_outline_rounded,
                          color: Colors.black,
                        ),
                        labelText: 'Full Name',
                        hintText: 'Enter name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name field cannot be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyTextFormField(
                        controller: phoneNoController,
                        icon: Icon(
                          Icons.phone_android_outlined,
                          color: Colors.black,
                        ),
                        labelText: 'Phone No.',
                        hintText: 'Enter Phone No.',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone No field cannot be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      MyTextFormField(
                        controller: emailController,
                        icon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        labelText: 'E-mail id',
                        hintText: 'Enter E-mail id',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email field cannot be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      MyTextFormField(
                        controller: passwordController,
                        hintText: 'Enter Password',
                        labelText: 'Password',
                        icon: Icon(
                          Icons.fingerprint_outlined,
                          color: Colors.black,
                          size: 25,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password field cannot be empty';
                          } else if (value.length < 12) {
                            return 'Password length must be atleast 12';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Material(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.circular(changeButton ? 40 : 80),
                          child: InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  changeButton = true;
                                });
                                await Future.delayed(
                                  Duration(seconds: 1),
                                );

                                setState(() {
                                  changeButton = false;
                                });
                              }
                              String res =
                                  await Auththentication.instance.signupUser(
                                fullName: fullNameController.text.trim(),
                                emailAddress: emailController.text.trim(),
                                passWord: passwordController.text.trim(),
                                phoneNumber: phoneNoController.text.trim(),
                                image: image,
                              );
                              if (res == "success") {
                                Get.snackbar('Success',
                                    'Your account has successfully created');
                              } else {
                                Get.snackbar("Error", res);
                              }
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              width: changeButton ? 40 : 200,
                              height: 40,
                              alignment: Alignment.center,
                              child: changeButton
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Signup",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
