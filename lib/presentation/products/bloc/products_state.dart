import 'package:rekrutacja_ai_native/domain/entities/product.dart';

abstract class ProductsState {}

class ProductsInitialState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final List<Product> productsList;
  final List<Product> filteredProducts;

  ProductsLoadedState({
    required this.productsList,
    required this.filteredProducts,
  });
}

class ProductsErrorState extends ProductsState {
  final String message;

  ProductsErrorState({required this.message});
}
