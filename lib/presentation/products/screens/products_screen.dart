import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_bloc.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_event.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_state.dart';
import 'package:rekrutacja_ai_native/presentation/products/widgets/no_products_matching.dart';
import 'package:rekrutacja_ai_native/presentation/products/widgets/products_exception_widget.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("Produkty"),
        backgroundColor: const Color.fromARGB(255, 246, 227, 227),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              autocorrect: false,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Wyszukaj produkt...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) =>
                  context.read<ProductsBloc>().add(SearchProductEvent(value)),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductsErrorState) {
                    return ProductsExceptionWidget(message: state.message);
                  } else if (state is ProductsLoadedState) {
                    final products = state.filteredProducts;
                    if (products.isEmpty) return NoProductsMatching();

                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Card(
                          color: const Color.fromARGB(255, 246, 227, 227),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(
                              Icons.label_important_rounded,
                              color: Colors.red,
                            ),
                            title: Text(product.title),
                            subtitle: Text('${product.price}'),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
