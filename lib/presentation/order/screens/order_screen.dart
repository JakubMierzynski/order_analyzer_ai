import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: Text("Orders"),
        backgroundColor: const Color.fromARGB(255, 246, 227, 227),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(child: Text("ASYSTENT ZAMÓWIENIA")),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: const FaIcon(FontAwesomeIcons.robot, size: 30, color: Colors.black54,),
                      ),
                      hintText: "Wpisz swoje zamówienie",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 246, 227, 227),
                  foregroundColor: Colors.black54,
                  elevation: 0,
                  onPressed: () {},
                  child: Icon(Icons.send_rounded, size: 30,),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Card(
                color: Color.fromARGB(255, 246, 227, 227),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Text(answer, style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String answer =
    "od tempor incididunt utsed do eiusmod tempor incididunt utsed do eiusmod tempor incididunt utsed do eiusmod tempor incididunt utsed do eiusmod tempor incididunt utsed do eiusmod tempor incididunt utsed do eiusmod tempor incididunt ut sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
