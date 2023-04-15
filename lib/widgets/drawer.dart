// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/auth_repo.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/uoi.png")),
                  accountName: Text("Amit Sharma"),
                  accountEmail: Text("amitterisharma@gmail.com"))),
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
          )
        ],
      ),
    );
  }
}
