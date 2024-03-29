import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:linen_republic/features/home/model/product_model.dart';
import 'package:linen_republic/features/product/controller/product_repo/product_repo.dart';

class ProductServices implements ProductRepository {
  final firebase = FirebaseFirestore.instance;
  @override
  Future<Either<String, List<ProductModel>>> getProducts() async {
    try {
      final querySnapshot = await firebase.collection('products').get();
      final products = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();
      return right(products);
    } catch (e) {
      return left(e.toString());
    }
  }
}
