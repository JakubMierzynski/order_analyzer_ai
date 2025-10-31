import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rekrutacja_ai_native/data/repositories/product_repository.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_event.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository productRepository;

  ProductsBloc(this.productRepository) : super(ProductsInitialState()) {
    on<LoadProductsEvent>(_onLoadProducts);
    add(LoadProductsEvent()); 
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoadingState());
    print("ProductsLoadingState");

    try {
      final productsList = await productRepository.fetchProducts();
      emit(ProductsLoadedState(productsList: productsList));
      print("ProductsLoadedState");
    } catch (e) {
      emit(ProductsErrorState(message: e.toString()));
      print(e.toString());
    }
  }
}
