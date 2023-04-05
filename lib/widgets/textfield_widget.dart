// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Icon icon;
  final TextInputType keyboardType;
  final bool isPass;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;

  MyTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.isPass = false,
    required this.validator,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: Theme.of(context).cardColor),
        hintStyle: TextStyle(color: Theme.of(context).cardColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).cardColor),
        ),
        icon: icon,
      ),
      keyboardType: keyboardType,
      obscureText: isPass,
      validator: validator,
    );
  }
}
