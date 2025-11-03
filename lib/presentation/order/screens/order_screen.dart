import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rekrutacja_ai_native/data/repositories/llm_repository.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController controller = TextEditingController();
  String answer =
      "od tempor incididunt utsed do eiusmod tempor incididunt utsed do eiusmod tempor incididunt utsed do eiusmod tempor incididunt utsed do eiusmod tempor incididunt utsed do eiusmod tempor incididunt utsed do eiusmod tempor incididunt ut sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _talkToAI() async {
    String AiAnswer = await getLLMResponse(controller.text);
    setState(() {
      answer = AiAnswer;
    });
  }

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
            Center(
              child: Text(
                "ASYSTENT ZAMÓWIENIA",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: const FaIcon(
                            FontAwesomeIcons.robot,
                            size: 30,
                            color: Colors.red,
                          ),
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
                    foregroundColor: Colors.red,
                    elevation: 0,
                    onPressed: _talkToAI,
                    child: Icon(Icons.send_rounded, size: 30),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
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
