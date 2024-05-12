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

  // import 'package:cloud_firestore/cloud_firestore.dart';
  @override
  Future<Either<String, List<ProductModel>>> searchProducts(
      String query) async {
    try {
      QuerySnapshot querySnapshot;

      if (query.isNotEmpty) {
        // If a query is provided, perform a search based on the product name
        querySnapshot = await firebase
            .collection('products')
            .where('nameLower', isGreaterThanOrEqualTo: query.toLowerCase())
            .where('nameLower', isLessThan: '${query.toLowerCase()}z')
            .get();
      } else {
        // Otherwise, fetch all products
        querySnapshot = await firebase.collection('products').get();
      }

      final products = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();

      return right(products);
    } catch (e) {
      return left(e.toString());
    }
  }
}
