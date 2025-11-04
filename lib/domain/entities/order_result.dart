import 'package:rekrutacja_ai_native/domain/entities/order_item.dart';

class OrderResult {
  final List<OrderItem> order;
  final double grandTotal;

  OrderResult({required this.order, required this.grandTotal});

  factory OrderResult.fromJson(Map<String, dynamic> json) => OrderResult(
    order: (json['order'] as List)
        .map((item) => OrderItem.fromJson(item))
        .toList(),
    grandTotal: (json['grandTotal'] as num).toDouble(),
  );
}
