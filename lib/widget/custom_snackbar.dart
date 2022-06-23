import 'package:flutter/material.dart';

class CustomSnackBar{
  CustomSnackBar._();
  static buildSnackBar(BuildContext context, String message, Color color){
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), backgroundColor: color, behavior: SnackBarBehavior.floating,));
  }
}