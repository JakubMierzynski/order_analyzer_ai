import 'package:flutter/material.dart';
import 'package:rekrutacja_ai_native/domain/entities/order_item.dart';
import 'package:rekrutacja_ai_native/domain/entities/order_result.dart';

class OrderTable extends StatelessWidget {
  final OrderResult orderResult;

  const OrderTable({super.key, required this.orderResult});

  @override
  Widget build(BuildContext context) {
    final matchedItems = orderResult.order
        .where((item) => item.status == "OK")
        .toList();
    final unmatchedItems = orderResult.order
        .where((item) => item.status != "OK")
        .toList();

    if (matchedItems.isNotEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // tabela z dopasowanymi produktami
            DataTable(
              columnSpacing: 30,
              columns: [
                buildDataColumn("Produkty"),
                buildDataColumn("Ilość"),
                buildDataColumn("Cena"),
                buildDataColumn("Suma"),
              ],
              rows: matchedItems.map((OrderItem item) {
                return DataRow(
                  cells: [
                    // komórka z produkt name jest scrollable. Dluga nazwa produktu moze byc
                    // Dluga nazwa produktu moze byc problemem dla ukladu
                    DataCell(
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: 100),
                          child: Text(
                            item.productName,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text(item.quantity?.toString() ?? "-")),
                    DataCell(Text(item.unitPrice?.toStringAsFixed(2) ?? "-")),
                    DataCell(Text(item.totalPrice?.toStringAsFixed(2) ?? "-")),
                  ],
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            // Suma całkowita zamówienia
            Text(
              "Suma całkowita: ${orderResult.grandTotal.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            // Niedopasowane produkty
            if (unmatchedItems.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                "Nie udało się dopasować:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              buildUnmachedColumn(unmatchedItems),
            ],
          ],
        ),
      );
    } else {
      return buildUnmachedColumn(unmatchedItems);
    }
  }
}

DataColumn buildDataColumn(String title) {
  return DataColumn(
    label: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}

Column buildUnmachedColumn(List unmatchedItems) {
  return Column(
    children: unmatchedItems.map((item) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
        ),
        child: Text(
          "• ${item.productName} (ilość: ${item.quantity ?? '-'})",
          style: const TextStyle(fontSize: 18, color: Colors.red),
        ),
      );
    }).toList(),
  );
}
