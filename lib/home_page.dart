import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  int days = 30;
  String name = "Amit sharma";

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("This is my $days flutter tutorial by $name"),
      ),
    );
  }
}
