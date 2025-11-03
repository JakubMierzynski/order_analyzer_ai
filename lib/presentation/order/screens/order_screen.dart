import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rekrutacja_ai_native/data/repositories/llm_repository.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController controller = TextEditingController();
  bool isLoading = false;
  String answer = "";

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _talkToAI() async {
    setState(() => isLoading = true);

    try {
      final aiAnswer = await getLLMResponse(controller.text);
      setState(() => answer = aiAnswer);
    } catch (e) {
      setState(() => answer = "Błąd podczas komunikacji z AI: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("Orders"),
        backgroundColor: Color.fromARGB(255, 246, 227, 227),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Center(
              child: Text(
                "ASYSTENT ZAMÓWIENIA",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: FaIcon(
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
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 246, 227, 227),
                    foregroundColor: Colors.red,
                    elevation: 0,
                    onPressed: isLoading ? null : _talkToAI,
                    child: isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: CircularProgressIndicator(
                              color: Colors.red,
                              strokeWidth: 3,
                            ),
                          )
                        : const Icon(Icons.send_rounded, size: 30),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Card(
                color: const Color.fromARGB(255, 246, 227, 227),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: answer.isEmpty
                      ? _buildEmptyState()
                      : SingleChildScrollView(
                          child: Text(
                            answer,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          FaIcon(FontAwesomeIcons.basketShopping, color: Colors.red, size: 80),
          SizedBox(height: 10),
          Text(
            "Brak zamówień",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "Dodaj zamówienie z pomocą naszego asystenta",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
