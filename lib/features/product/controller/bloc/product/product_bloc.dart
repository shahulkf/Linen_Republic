import 'package:bloc/bloc.dart';
import 'package:linen_republic/features/home/model/product_model.dart';
import 'package:linen_republic/features/product/controller/product_repo/product_repo.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepo;
  ProductBloc(this.productRepo) : super(ProductInitial()) {
    on<FetchProductsEvent>((event, emit) async {
      emit(ProductFetchLoadingState());
      final response = await productRepo.getProducts();

      response.fold((l) => emit(ProductFetchErrorState(message: l)), (r) {
        final sorted =
            r.where((element) => element.category == event.category).toList();
        emit(ProductFetchSuccessState(products: sorted.isEmpty ? r : sorted));
      });
    });
    on<SelectSizeEvent>((event, emit) {
      final available = event.sizeWithQuantity[event.size] ?? 0;
      emit(SelectedSizeState(available: available, selectedSize: event.size));
    });
  }
}
