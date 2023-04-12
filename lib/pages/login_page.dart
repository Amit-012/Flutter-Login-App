// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:demoapp/pages/signup_page.dart';
import 'package:demoapp/pages/home_page.dart';
import 'package:demoapp/resources/repositary/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'forget_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 40,
                    left: 10,
                    child: IconButton(
                        onPressed: () => Get.to(() => HomePage()),
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).cardColor,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 160.0, vertical: 45.0),
                    child: SizedBox(
                      height: 40,
                      child: Image.asset('assets/images/uoilogo.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 150.0),
                    child: Text(
                      'Signin to',
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                  Positioned(
                    top: 151,
                    left: 162,
                    child: SizedBox(
                        height: 40,
                        child:
                            Image(image: AssetImage('assets/images/logo.png'))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 250.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                                borderSide: BorderSide(
                                    color: Theme.of(context).cardColor),
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
                            height: 20,
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
                                borderSide: BorderSide(
                                    color: Theme.of(context).cardColor),
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Get.to(() => ForgetPassword());
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  'Forget Password',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 57, 121, 232),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Material(
                            elevation: 0.0,
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.circular(changeButton ? 40 : 80),
                            child: InkWell(
                              onTap: () async {
                                Auththentication.instance.login(
                                    emailController.text.trim(),
                                    passwordController.text.trim());
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    changeButton = true;
                                  });
                                  await Future.delayed(Duration(seconds: 1));

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
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 60, top: 30),
                            child: Row(
                              children: [
                                Text('Not a member?'),
                                TextButton(
                                  onPressed: () {
                                    Get.to(() => SignupPage());
                                  },
                                  child: Text(
                                    'Register now',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 57, 121, 232),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
