import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoProductsMatching extends StatelessWidget {
  const NoProductsMatching({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.ghost, size: 150, color: Colors.red),
          SizedBox(height: 25),
          Text(
            "Brak produktów spełniających kryteria",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text("Spróbuj ponownie", style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
