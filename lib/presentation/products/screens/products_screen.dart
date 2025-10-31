import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rekrutacja_ai_native/domain/entities/product.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_bloc.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_state.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: Center(
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return CircularProgressIndicator();
            } else if (state is ProductsErrorState) {
              return Text(state.message);
            } else if (state is ProductsLoadedState) {
              final List<Product> products = state.productsList;

              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text(product.price.toString()),
                  );
                },
              );
            } else {
              return Center(child: Text("No products loaded"));
            }
          },
        ),
      ),
    );
  }
}
