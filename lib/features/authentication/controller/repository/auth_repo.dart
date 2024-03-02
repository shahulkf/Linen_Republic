import 'package:dartz/dartz.dart';
import 'package:linen_republic/features/authentication/model/login_model.dart';
import 'package:linen_republic/features/authentication/model/sign_up_model.dart';

abstract class AuthenticationRepository {
  Future<Either<String, String>> signUpUser({required SignUpModel signUpModel});
  Future<Either<String, String>> loginUser({required LoginModel loginModel});
  Future<Either<String, String>> googleAuth();
}
