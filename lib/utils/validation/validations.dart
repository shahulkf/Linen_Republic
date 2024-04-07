import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linen_republic/features/account/controller/bloc/bloc/address_bloc.dart';
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

String addressValidation(TextEditingController controller, context) {
  final adressProvider = BlocProvider.of<AddressBloc>(context);

  if (adressProvider.fullNameController == controller) {
    return 'Full Name is required';
  } else if (adressProvider.phoneNumberController == controller) {
    return 'Phone Number is required';
  } else if (adressProvider.pincodeController == controller) {
    return 'Pincode is required';
  } else if (adressProvider.cityController == controller) {
    return 'City is required';
  } else if (adressProvider.stateController == controller) {
    return 'State is required';
  } else if (adressProvider.localityController == controller) {
    return 'Locality is required';
  } else if (adressProvider.flatNoController == controller) {
    return 'Flat No is required';
  } else if (adressProvider.landmarkController == controller) {
    return 'LandMark is required';
  } else {
    return 'Field is required';
  }
}
