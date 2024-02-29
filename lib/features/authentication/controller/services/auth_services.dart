import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linen_republic/features/authentication/controller/repository/auth_repo.dart';
import 'package:linen_republic/features/authentication/model/login_model.dart';
import 'package:linen_republic/features/authentication/model/sign_up_model.dart';

class AuthenticationServices implements AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Either<String, String>> signUpUser(
      {required SignUpModel signUpModel}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: signUpModel.email, password: signUpModel.password);
      return right('success');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return left(
              'Email already existing. Please check your email and try again.');

        case 'weak-password':
          return left('Weak password. Please try again.');

        case 'invalid-email':
          return left('Invalid email address. Please enter a valid email.');

        default:
          return left('An error occurred. Please try again later.');
      
      }
    }
  }

  @override
  Future<Either<String, String>> loginUser(
      {required LoginModel loginModel}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: loginModel.email, password: loginModel.password);
      return right('Login Successful');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return left('User not found. Please check your email and try again.');
        case 'wrong-password':
          return left('Invalid password. Please try again.');
        case 'invalid-email':
          return left('Invalid email address. Please enter a valid email.');
        default:
          return left('An error occurred. Please try again later.');
      }
    }
  }
}
