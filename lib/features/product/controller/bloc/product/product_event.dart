part of 'product_bloc.dart';

class ProductEvent {}

class FetchProductsEvent extends ProductEvent {
  final String category;

  FetchProductsEvent({required this.category});
  
}

class SelectSizeEvent extends ProductEvent {
  String size;
  Map<String, int> sizeWithQuantity;
  SelectSizeEvent({
    required this.size,
    required this.sizeWithQuantity,
  });
}

