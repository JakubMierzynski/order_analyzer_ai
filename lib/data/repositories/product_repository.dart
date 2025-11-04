import 'dart:convert';
import 'dart:io';

import 'package:rekrutacja_ai_native/constants/api_constants.dart';
import 'package:rekrutacja_ai_native/domain/entities/product.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    try {
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
        throw ProductApiException("Błąd serwera: ${response.statusCode}");
      }
    } on SocketException catch (_) {
      throw ProductNetworkException(
        "Brak połączenia z internetem lub niepoprawny host",
      );
    } catch (e) {
      throw ProductUnknownException("Nieznany błąd. Spróbuj ponownie później");
    }
  }
}

class ProductApiException implements Exception {
  final String message;
  ProductApiException(this.message);

  @override
  String toString() => message;
}

class ProductNetworkException implements Exception {
  final String message;
  ProductNetworkException(this.message);

  @override
  String toString() => message;
}

class ProductUnknownException implements Exception {
  final String message;
  ProductUnknownException(this.message);

  @override
  String toString() => message;
}
