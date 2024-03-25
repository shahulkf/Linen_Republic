part of 'product_bloc.dart';

class ProductEvent {}

class FetchProductsEvent extends ProductEvent {}

class SelectSizeEvent extends ProductEvent {
  String size;
  Map<String, int> sizeWithQuantity;
  SelectSizeEvent({
    required this.size,
    required this.sizeWithQuantity,
  });
}
