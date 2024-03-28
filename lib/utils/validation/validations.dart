import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linen_republic/features/authentication/controller/bloc/bloc/auth_bloc.dart';

String fieldIsEmpty(TextEditingController controller, context) {
  final provider = BlocProvider.of<AuthBlocBloc>(context);
  if (provider.loginEmailController == controller) {
    return 'Email is required';
  } else if (provider.loginPasswordController == controller) {
    return 'Password is required';
  } else if (provider.userNameController == controller) {
    return 'UserName is required';
  } else if (provider.emailController == controller) {
    return 'Email is required';
  } else if (provider.passwordController == controller) {
    return 'Password is required';
  } else if (provider.confirmPasswordcontroller == controller) {
    return 'Confirmation of password is required';
  } else {
    return 'Field is required';
  }
}
