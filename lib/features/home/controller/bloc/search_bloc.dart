import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:linen_republic/features/home/model/product_model.dart';
import 'package:linen_republic/features/product/controller/product_repo/product_repo.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRepository productRepo;
  SearchBloc(this.productRepo) : super(SearchInitial()) {
    on<FilterByLowToHigh>(_filterByLowToHigh);

    on<FilterByHighToLow>(_filterByHighToLow);

    on<FilterByAll>(_filterByAll);

    on<FilterByUnder999>(_filterByUnder999);

    on<SearchProductEvent>(_searchProductEvent);
  }

  FutureOr<void> _filterByLowToHigh(
      FilterByLowToHigh event, Emitter<SearchState> emit) async {
    final response = await productRepo.getProducts();
    response.fold((l) {
      emit(FilterErrorState());
    }, (products) {
      products.sort((a, b) => a.price.compareTo(b.price));
      emit(FilterSuccessState(products: products));
    });
  }

  FutureOr<void> _filterByHighToLow(
      FilterByHighToLow event, Emitter<SearchState> emit) async {
    final response = await productRepo.getProducts();
    response.fold((l) {
      emit(FilterErrorState());
    }, (products) {
      products.sort((a, b) => b.price.compareTo(a.price));

      emit(FilterSuccessState(products: products));
    });
  }

  FutureOr<void> _filterByAll(
      FilterByAll event, Emitter<SearchState> emit) async {
    final response = await productRepo.getProducts();
    response.fold((l) {
      emit(FilterErrorState());
    }, (products) {
      emit(FilterSuccessState(products: products));
    });
  }

  FutureOr<void> _filterByUnder999(
      FilterByUnder999 event, Emitter<SearchState> emit) async {
    final response = await productRepo.getProducts();
    response.fold((l) {
      emit(FilterErrorState());
    }, (products) {
      products = products.where((product) => product.price < 999).toList();
      emit(FilterSuccessState(products: products));
    });
  }

  FutureOr<void> _searchProductEvent(
      SearchProductEvent event, Emitter<SearchState> emit) async {
    final response = await productRepo.searchProducts(event.query);
    response.fold((l) {
      emit(FilterErrorState());
    }, (products) {
      emit(FilterSuccessState(products: products));
    });
  }
}
