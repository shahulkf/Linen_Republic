import 'package:flutter/material.dart';

class Responsive {
  static double height = 0;
  static double width = 0;

  static initScreenSize(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}
