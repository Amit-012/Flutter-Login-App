// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/pages/signup_page.dart';

import 'package:demoapp/utils/utils.dart';
import 'package:demoapp/widgets/drawer.dart';
import 'package:demoapp/widgets/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var creationTime = FirebaseAuth.instance.currentUser?.metadata.creationTime;
  CollectionReference reference =
      FirebaseFirestore.instance.collection('users');
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNoController = TextEditingController();
  var fullNameController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).canvasColor,
                  child: ListTile(
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(snapshot
                            .data!.docs[index]['photo_url']
                            .toString())),
                    title: Text(snapshot.data!.docs[index]['full_name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data!.docs[index]['email']),
                        Text(snapshot.data!.docs[index]['phone_number'])
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        emailController.text =
                            snapshot.data!.docs[index]['email'];
                        passwordController.text =
                            snapshot.data!.docs[index]['password'];
                        fullNameController.text =
                            snapshot.data!.docs[index]['full_name'];
                        phoneNoController.text =
                            snapshot.data!.docs[index]['phone_number'];

                        showBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            padding: EdgeInsets.all(20),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: selectImage,
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Stack(
                                        children: [
                                          image != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image(
                                                      image:
                                                          MemoryImage(image!)),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image(
                                                      image: NetworkImage(
                                                          snapshot.data
                                                                  ?.docs[index]
                                                              ['photo_url'])),
                                                ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Icon(
                                                Icons.add_a_photo,
                                                color: Theme.of(context)
                                                    .canvasColor,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        MyTextFormField(
                                          controller: fullNameController,
                                          icon: Icon(
                                            Icons.person_outline_rounded,
                                            color: Colors.black,
                                          ),
                                          labelText: 'Full Name',
                                          hintText: 'Enter full name',
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
                                          labelText: 'Phone No',
                                          hintText: 'Enter phone No.',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'PhoneNo field cannot be empty';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
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
                                          height: 20,
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
                                          height: 40,
                                        ),
                                        Material(
                                          elevation: 0.0,
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(
                                              changeButton ? 40 : 80),
                                          child: InkWell(
                                            onTap: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  changeButton = true;
                                                });
                                                await Future.delayed(
                                                    Duration(seconds: 1));

                                                if (mounted) {
                                                  setState(
                                                    () {
                                                      changeButton = false;
                                                    },
                                                  );
                                                }
                                              }
                                              reference
                                                  .doc(snapshot
                                                      .data!.docs[index]['uid'])
                                                  .update({
                                                'full_name':
                                                    fullNameController.text,
                                                'email': emailController.text,
                                                'password':
                                                    passwordController.text,
                                                'phone_number':
                                                    phoneNoController.text,
                                                // 'photo_url': StorageMethods()
                                                //     .uploadImageToStorage(
                                                //         'Profile Pic', image!)
                                              }).whenComplete(() =>
                                                      navigator!.pop(context));
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
                                                      "Update",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Created: $creationTime',
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          reference
                                              .doc(snapshot.data!.docs[index]
                                                  ['uid'])
                                              .delete()
                                              .whenComplete(() =>
                                                  Get.to(() => SignupPage()));
                                        },
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 232, 57, 57),
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
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      drawer: Mydrawer(),
    );
  }
}
