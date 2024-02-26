import 'package:flutter/material.dart';
import 'package:linen_republic/constants/colors/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.child,
    this.backgroundColor = ConstColor.blackColor,
    this.height = 55,
    this.width = 100,
    required this.onTap,
    super.key,
  });
  final Widget child;
  final Color backgroundColor;
  final double height;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: backgroundColor),
        height: height,
        width: width,
        child: Center(child: child),
      ),
    );
  }
}
