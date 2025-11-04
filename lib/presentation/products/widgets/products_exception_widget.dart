import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductsExceptionWidget extends StatelessWidget {
  final String message;
  const ProductsExceptionWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
            size: 120,
          ),
          SizedBox(height: 25),
          Text(
            message,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text("Spróbuj ponownie", style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
