part of 'auth_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

// SIGNUP STATE

class SignUpLoadingState extends AuthBlocState {}

class SignUpSuccessState extends AuthBlocState {
  final String message;
  SignUpSuccessState({required this.message});
}

class SignUpErrorState extends AuthBlocState {
  final String message;
  SignUpErrorState({required this.message});
}

// LOGINSTATE

class LoginLoadingState extends AuthBlocState {}

class LoginSuccessState extends AuthBlocState {
  final String message;
  LoginSuccessState({required this.message});
}

class LoginErrorState extends AuthBlocState {
  final String message;
  LoginErrorState({required this.message});
}

//google account
class GoogleAuthLoadingState extends AuthBlocState {}

class GoogleAuthSuccessState extends AuthBlocState {
  final String message;
  GoogleAuthSuccessState({required this.message});
}

class GoogleAuthErrorState extends AuthBlocState {
  final String message;
  GoogleAuthErrorState({required this.message});
}
