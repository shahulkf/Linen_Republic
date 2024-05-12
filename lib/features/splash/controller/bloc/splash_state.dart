part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

class NavigateToHomeState extends SplashState{}

class NavigateToAuthState extends SplashState{}
