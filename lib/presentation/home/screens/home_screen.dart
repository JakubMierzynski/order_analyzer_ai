import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rekrutacja_ai_native/presentation/order/screens/order_screen.dart';
import 'package:rekrutacja_ai_native/presentation/products/screens/products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> screens = [const ProductsScreen(), const OrderScreen()];

  final Color selectedColor = Colors.redAccent;
  final Color unselectedColor = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: screens[currentTab]),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        shape: const CircularNotchedRectangle(),
        notchMargin: 15,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                icon: FontAwesomeIcons.list,
                label: "Products",
                index: 0,
              ),
              _buildNavItem(
                icon: FontAwesomeIcons.cartShopping,
                label: "Order",
                index: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = currentTab == index;
    final color = isSelected ? selectedColor : unselectedColor;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => setState(() => currentTab = index),
      splashColor: selectedColor.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, color: color),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
