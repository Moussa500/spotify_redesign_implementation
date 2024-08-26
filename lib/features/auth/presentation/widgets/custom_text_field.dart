import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String hintText;
  bool ? obscured;
  TextEditingController controller;
  CustomTextField({super.key, required this.hintText,required this.controller,this.obscured});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: TextField(
        controller: controller,
        obscureText: obscured??false,
        decoration: InputDecoration(hintText: hintText).applyDefaults(
          Theme.of(context).inputDecorationTheme,
        ),
      ),
    );
  }
}
