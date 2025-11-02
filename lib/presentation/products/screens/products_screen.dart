import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rekrutacja_ai_native/domain/entities/product.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_bloc.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_event.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_state.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductsScreenState();
  }
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("Products"),
        backgroundColor: const Color.fromARGB(255, 246, 227, 227),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 350,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) {
                      context.read<ProductsBloc>().add(
                        SearchProductEvent(value),
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.search),
              ],
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 620,
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProductsErrorState) {
                    return Text(state.message);
                  } else if (state is ProductsLoadedState) {
                    final List<Product> products = state.filteredProducts;

                    if (products.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.ghost,
                              size: 150,
                              color: Colors.red,
                            ),
                            SizedBox(height: 25),
                            Text(
                              "No products matching criteria",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text("Try again", style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 246, 227, 227),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.label_important_rounded,
                              color: Colors.red,
                            ),
                            title: Text(product.title),
                            subtitle: Text(product.price.toString()),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("No products loaded"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
