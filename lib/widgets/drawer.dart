// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/auth_repo.dart';

class Mydrawer extends StatelessWidget {
  Mydrawer({super.key});

  final currentUser = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getProfile() async {
    final result = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.currentUser?.uid)
        .get();
    return result.data();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder(
            future: getProfile(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>?> snapshot) {
              if (!snapshot.hasData) {
                return SafeArea(child: Text('Not logedin'));
              } else {
                return DrawerHeader(
                  decoration: BoxDecoration(color: Colors.deepPurple),
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: UserAccountsDrawerHeader(
                    margin: EdgeInsets.zero,
                    currentAccountPicture: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: NetworkImage(snapshot.data?['photo_url'] ?? ''),
                      ),
                    ),
                    accountName: Text(snapshot.data?['full_name']),
                    accountEmail: Text(snapshot.data?['email']),
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.home,
            ),
            title: Text("Home", textScaleFactor: 1.2),
          ),
          ListTile(
            leading: Icon(CupertinoIcons.profile_circled),
            title: Text("Profile", textScaleFactor: 1.2),
          ),
          ListTile(
            leading: Icon(CupertinoIcons.mail),
            title: Text("Mail Me", textScaleFactor: 1.2),
          ),
          InkWell(
            child: ListTile(
              leading: Icon(CupertinoIcons.person),
              onTap: () {
                Auththentication.instance.signOutUser();
              },
              title: Text("Logout", textScaleFactor: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}
