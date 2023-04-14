// ignore_for_file: prefer_const_constructors

import 'package:demoapp/resources/repositary/auth_repo.dart';
import 'package:demoapp/pages/home_page.dart';
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
  final phoneNoContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool changeButton = false;
  bool isStudent = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
                    width: 100,
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
              Row(
                children: const [
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Signup to',
                    style: TextStyle(fontSize: 28, color: Colors.black),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    height: 38,
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ],
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
                        controller: phoneNoContoller,
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
                              setState(() {
                                isLoading = true;
                              });

                              String res =
                                  await Auththentication.instance.signupUser(
                                fullName: fullNameController.text.trim(),
                                emailAddress: emailController.text.trim(),
                                passWord: passwordController.text.trim(),
                                phoneNumber: phoneNoContoller.text.trim(),
                              );
                              if (res == "success") {
                                setState(() {
                                  isLoading = false;
                                });
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                Get.snackbar("Error", res);
                              }

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
                                // Get.to(() => LoginPage());
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
