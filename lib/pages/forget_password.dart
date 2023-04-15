// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'dart:async';
import 'package:demoapp/resources/auth_repo.dart';
import 'package:demoapp/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int start = 30;
  bool wait = false;
  String buttonName = 'Send Mail';

  void startTimer() {
    const onsec = Duration(seconds: 1);

    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        if (mounted) {
          setState(() {
            start--;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter your email',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      controller: emailController,
                      hintText: 'Enter mail id',
                      labelText: 'Email',
                      icon: Icon(
                        Icons.mail_outline_rounded,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'E-mail field cannot be empaty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Row(
                        children: [
                          const Text('Send OTP again in '),
                          Text(
                            '00:$start',
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                          const Text(' sec'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(80),
                      child: InkWell(
                        onTap: wait
                            ? null
                            : () {
                                Auththentication.instance.resetPassword(
                                  email: emailController.text.trim(),
                                );
                                startTimer();
                                setState(() {
                                  start = 30;
                                  wait = true;
                                  buttonName = 'Resend Mail';
                                });
                                if (_formKey.currentState!.validate()) {
                                  Get.snackbar(
                                    "Please check Spam Email",
                                    "We have sent you a reset password mail.",
                                  );
                                }
                              },
                        child: SizedBox(
                          height: 40,
                          width: 150,
                          child: Center(
                            child: Text(
                              buttonName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
