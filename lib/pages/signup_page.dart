// ignore_for_file: prefer_const_constructors

import 'package:demoapp/models/user_model.dart';
import 'package:demoapp/pages/home_page.dart';
import 'package:demoapp/resources/repositary/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool changeButton = false;
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var fullNameController = TextEditingController();
    var phoneNoContoller = TextEditingController();
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
                      TextFormField(
                        controller: fullNameController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person_outline_rounded,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).cardColor),
                          ),
                          labelText: 'Full Name',
                          labelStyle:
                              TextStyle(color: Theme.of(context).cardColor),
                          hintText: 'Enter name',
                          hintStyle:
                              TextStyle(color: Theme.of(context).cardColor),
                        ),
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
                      TextFormField(
                        controller: phoneNoContoller,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.phone_android_outlined,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Phone No.',
                          hintText: 'Enter Phone No.',
                          labelStyle:
                              TextStyle(color: Theme.of(context).cardColor),
                          hintStyle:
                              TextStyle(color: Theme.of(context).cardColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).cardColor),
                          ),
                        ),
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
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'E-mail id',
                          hintText: 'Enter E-mail id',
                          labelStyle:
                              TextStyle(color: Theme.of(context).cardColor),
                          hintStyle:
                              TextStyle(color: Theme.of(context).cardColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).cardColor),
                          ),
                        ),
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
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Password',
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(color: Theme.of(context).cardColor),
                          hintStyle:
                              TextStyle(color: Theme.of(context).cardColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).cardColor),
                          ),
                          icon: Icon(
                            Icons.fingerprint_outlined,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                        obscureText: true,
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
                              final user = UserModel(
                                  fullNameController.text.trim(),
                                  phoneNoContoller.text.trim(),
                                  emailController.text.trim(),
                                  passwordController.text.trim());
                              Auththentication.instance.createUser(user);
                              Auththentication.instance.register(
                                  emailController.text.trim(),
                                  passwordController.text.trim());
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
