part of 'product_bloc.dart';

class ProductState {}

final class ProductInitial extends ProductState {}

class ProductFetchSuccessState extends ProductState {
  final List<ProductModel> products;
  ProductFetchSuccessState({required this.products});
}

class ProductFetchErrorState extends ProductState {
  final String message;
  ProductFetchErrorState({required this.message});
}

class ProductFetchLoadingState extends ProductState {}

class SelectedSizeState extends ProductState {
  int available;
  String selectedSize;
  SelectedSizeState({required this.available, required this.selectedSize});
}
