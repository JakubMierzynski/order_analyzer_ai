class OrderItem {
  final String productName;
  final int? quantity;
  final double? unitPrice;
  final double? totalPrice;
  final String status;

  OrderItem({
    required this.productName,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
    required this.status,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    productName: json['productName'],
    quantity: json['quantity'],
    unitPrice: json['unitPrice'],
    totalPrice: json['totalPrice'],
    status: json['status'],
  );
}
