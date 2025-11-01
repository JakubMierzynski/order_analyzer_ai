abstract class ProductsEvent {}

class LoadProductsEvent extends ProductsEvent {}

class SearchProductEvent extends ProductsEvent {
  final String query;
  
  SearchProductEvent(this.query);
}
