import 'package:dartz/dartz.dart';

abstract class CheckoutRepository {
  Future<Either<String, void>> fetchCheckoutData();
}
