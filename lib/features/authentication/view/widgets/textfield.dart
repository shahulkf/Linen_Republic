import 'package:flutter/material.dart';
import 'package:linen_republic/constants/colors/colors.dart';

class TextFieldWidget extends StatelessWidget {
 const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIcon,
     this.suffixIcon,
     this.obscureText = false,
    required controller

  }):_controller = controller;

  

  final TextEditingController _controller;

 final String hintText;
 final IconData prefixIcon;
 final IconData ? suffixIcon;
 final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: _controller,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon:  Icon(prefixIcon),
          suffixIcon:suffixIcon==null?  null : Icon(suffixIcon),
        
          focusedBorder:  OutlineInputBorder(
            borderSide:const BorderSide(color: ConstColor.blackColor),
              borderRadius: BorderRadius.circular(35)),
          border: OutlineInputBorder(
            borderSide:const BorderSide(color: ConstColor.blackColor),
              borderRadius: BorderRadius.circular(35))),
    );
  }
}