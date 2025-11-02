import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rekrutacja_ai_native/data/repositories/product_repository.dart';
import 'package:rekrutacja_ai_native/presentation/home/screens/home_screen.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ProductRepository productsRepository = ProductRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(
          create: (context) => ProductsBloc(productsRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 133, 118, 129),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
