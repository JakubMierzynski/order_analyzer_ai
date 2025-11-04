import 'dart:convert';

import 'package:rekrutacja_ai_native/constants/api_constants.dart';
import 'package:rekrutacja_ai_native/domain/entities/product.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(ApiConstants.productsUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final productsJson = data["products"] as List;

      final products = productsJson
          .map(
            (json) => Product(
              id: json['id'],
              title: json['title'],
              price: (json['price'] as num).toDouble(),
            ),
          )
          .toList();
      return products;
    } else {
      throw Exception("Failed to fetch products");
    }
  }
}
