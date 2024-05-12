import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3));
      if (FirebaseAuth.instance.currentUser == null) {
        emit(NavigateToAuthState());
      } else {
        emit(NavigateToHomeState());
      }
    });
  }
}
