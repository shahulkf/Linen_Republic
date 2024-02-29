import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic/features/authentication/controller/services/auth_services.dart';
import 'package:linen_republic/features/authentication/model/login_model.dart';
import 'package:linen_republic/features/authentication/model/sign_up_model.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordcontroller =
      TextEditingController();
       final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();


  final AuthenticationServices authenticationServices;


  AuthBlocBloc(this.authenticationServices) : super(AuthBlocInitial()) {
    on<SingUpClickedEvent>(_singUpClickedEvent);
    on<LoginClickedEvent>(_loginClickedEvent);
  }

  FutureOr<void> _singUpClickedEvent(
      SingUpClickedEvent event, Emitter<AuthBlocState> emit) async {
    emit(SignUpLoadingState());
    final response =
        await authenticationServices.signUpUser(signUpModel: event.signUpModel);
    response.fold((l) => emit(SignUpErrorState(message: l)),
        (r) => emit(SignUpSuccessState(message: r)));
  }

  FutureOr<void> _loginClickedEvent(
    LoginClickedEvent event, Emitter<AuthBlocState> emit)  async{
      emit(LoginLoadingState());
    final  response = await  authenticationServices.loginUser(loginModel: event.loginModel);
    response.fold((l) => emit(LoginErrorState(message: l)), (r) =>emit(LoginSuccessState(message: r)));
  }
}
