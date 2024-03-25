import 'package:dartz/dartz.dart';
import 'package:linen_republic/features/home/model/product_model.dart';

abstract class ProductRepository {
  Future<Either<String, List<ProductModel>>> getProducts();
}
