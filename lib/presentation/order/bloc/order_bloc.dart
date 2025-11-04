import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rekrutacja_ai_native/domain/entities/order_result.dart';
import 'package:rekrutacja_ai_native/domain/usecases/get_ai_response.dart';
import 'package:rekrutacja_ai_native/presentation/order/bloc/order_event.dart';
import 'package:rekrutacja_ai_native/presentation/order/bloc/order_state.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_bloc.dart';
import 'package:rekrutacja_ai_native/presentation/products/bloc/products_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetAiResponseUseCase getAIResponse;
  final ProductsBloc productsBloc;

  OrderBloc(this.getAIResponse, this.productsBloc) : super(OrderInitial()) {
    on<SendOrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final productsState = productsBloc.state;
        final products = productsState is ProductsLoadedState
            ? productsState.productsList
            : [];

        final prompt =
            """
Lista produktów (id, nazwa, cena):
${products.map((p) => "${p.id}. ${p.title} - ${p.price}").join("\n")}

Zamówienie użytkownika:
${event.prompt}

Twoje zadanie:
Dopasuj produkty do listy powyżej. Oblicz ilość * cena = suma.
Zwróć wynik **tylko w formacie JSON** w poniższej strukturze:
{
  "order": [
    {
      "productName": "Jabłko",
      "quantity": 2,
      "unitPrice": 1.5,
      "totalPrice": 3.0,
      "status": "OK"
    },
    {
      "productName": "Woda mineralna",
      "quantity": 1,
      "unitPrice": 2.0,
      "totalPrice": 2.0,
      "status": "OK"
    },
    {
      "productName": "Chleb żytni",
      "quantity": 1,
      "unitPrice": null,
      "totalPrice": null,
      "status": "Niedopasowanie"
    }
  ],
  "grandTotal": 5.0
}
""";
        final answer = await getAIResponse(prompt);
        final jsonResponse = jsonDecode(answer);
        final orderResult = OrderResult.fromJson(jsonResponse);

        emit(OrderSuccess(orderResult));
      } catch (e) {
        emit(OrderError(e.toString()));
      }
    });
  }
}
