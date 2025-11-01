import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rekrutacja_ai_native/data/repositories/product_repository.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_event.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository productRepository;

  ProductsBloc(this.productRepository) : super(ProductsInitialState()) {
    on<LoadProductsEvent>(_onLoadProducts);
    add(LoadProductsEvent());

    on<SearchProductEvent>(_onSearchProducts);
  }

  Future<void> _onSearchProducts(
    SearchProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    final currentState = state;

    if (currentState is ProductsLoadedState) {
      final filteredList = currentState.productsList
          .where(
            (product) =>
                product.title.toLowerCase().contains(event.query.toLowerCase()),
          )
          .toList();
      emit(
        ProductsLoadedState(
          productsList: currentState.productsList,
          filteredProducts: filteredList,
        ),
      );
    }
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoadingState());
    print("ProductsLoadingState");

    try {
      final productsList = await productRepository.fetchProducts();
      emit(
        ProductsLoadedState(
          productsList: productsList,
          filteredProducts: productsList,
        ),
      );
      print("ProductsLoadedState");
    } catch (e) {
      emit(ProductsErrorState(message: e.toString()));
      print(e.toString());
    }
  }
}
