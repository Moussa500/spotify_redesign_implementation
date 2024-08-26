import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final  void Function()? onPressed;
  final String title;
  final double ? height;
  const BasicAppButton({this.height,super.key,required this.onPressed,required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:onPressed ,
      style: ElevatedButton.styleFrom(minimumSize:  Size.fromHeight(height ?? 80)),
      child: Text(title,style:const TextStyle(color: Colors.white),),
    );
  }
}