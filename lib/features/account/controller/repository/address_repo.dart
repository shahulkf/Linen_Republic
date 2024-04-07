import 'package:dartz/dartz.dart';
import 'package:linen_republic/features/account/model/address/address_model.dart';

abstract class AddressRepo {
  Future<Either<String, String>> addAddress(AddressModel addressModel);

  Future<Either<String, List<AddressModel>>> getAddress();
}
