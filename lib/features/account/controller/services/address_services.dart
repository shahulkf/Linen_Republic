import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linen_republic/features/account/controller/repository/address_repo.dart';
import 'package:linen_republic/features/account/model/address/address_model.dart';

class AddressService implements AddressRepo {
  final firebase = FirebaseFirestore.instance;
  @override
  Future<Either<String, String>> addAddress(AddressModel addressModel) async {
    try {
      await firebase
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Address')
          .doc(addressModel.id)
          .set({
        ...addressModel.toMap(),
        'id': addressModel.id,
      });
      return right('address added succesfully');
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<AddressModel>>> getAddress() async {
    try {
      final response = await firebase
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Address')
          .get();
      final addresses =
          response.docs.map((e) => AddressModel.fromMap(e.data())).toList();
      return right(addresses);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteAddress({required String id}) async {
    try {
      await firebase
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Address')
          .doc(id)
          .delete();
      return right('Address Delete Successfully');
    } catch (e) {
      return left('Something went Wrong $e');
    }
  }

  @override
  Future<Either<String, String>> updateAddress(
      {required AddressModel addressModel}) async {
    try {
      await firebase
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Address')
          .doc(addressModel.id)
          .update(addressModel.toMap());
      return right('Address Edited Successfully');
    } catch (e) {
      return left('Something went Wrong');
    }
  }
}
