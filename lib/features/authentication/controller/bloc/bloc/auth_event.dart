part of 'auth_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

class SingUpClickedEvent extends AuthBlocEvent {
  final SignUpModel signUpModel;

  SingUpClickedEvent({required this.signUpModel});
}

class LoginClickedEvent extends AuthBlocEvent {
  final LoginModel loginModel;
  
  LoginClickedEvent({required this.loginModel});
}
