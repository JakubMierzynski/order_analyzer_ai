import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rekrutacja_ai_native/data/repositories/llm_repository.dart';
import 'package:rekrutacja_ai_native/presentation/order/bloc/order_bloc.dart';
import 'package:rekrutacja_ai_native/presentation/order/bloc/order_event.dart';
import 'package:rekrutacja_ai_native/presentation/order/bloc/order_state.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      final isLoading = state is OrderLoading;

                      return FloatingActionButton(
                        backgroundColor: const Color.fromARGB(
                          255,
                          246,
                          227,
                          227,
                        ),
                        foregroundColor: Colors.red,
                        elevation: 0,
                        onPressed: isLoading
                            ? null
                            : () {
                                context.read<OrderBloc>().add(
                                  SendOrderEvent(controller.text),
                                );
                              },
                        child: isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Icon(Icons.send_rounded, size: 30),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                Widget content;

                if (state is OrderError) {
                  content = _buildErrorState(state.message);
                } else if (state is OrderSuccess) {
                  content = SingleChildScrollView(
                    child: Text(state.answer, style: TextStyle(fontSize: 20)),
                  );
                } else {
                  // OrderInitial lub OrderLoading
                  content = _buildEmptyState();
                }

                return Expanded(
                  child: Card(
                    color: const Color.fromARGB(255, 246, 227, 227),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: content,
                    ),
                  ),
                );
              },
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

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.red,
            size: 80,
          ),
          SizedBox(height: 20),
          Text(
            "Wystąpił błąd podczas łączenia z asystentem",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            "Sprawdź połączenie z internetem lub spróbuj ponownie później",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
