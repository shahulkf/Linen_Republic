import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linen_republic/features/checkout/controller/repository/checkout_repo.dart';

class CheckoutServices implements CheckoutRepository {
  @override
  Future<Either<String, void>> fetchCheckoutData() async {
    try {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .get();
      // ignore: void_checks
      return right(Void);
    } catch (e) {
      return left('l');
    }
  }
}
