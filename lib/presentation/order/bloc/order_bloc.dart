import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rekrutacja_ai_native/domain/usecases/get_ai_response.dart';
import 'package:rekrutacja_ai_native/presentation/order/bloc/order_event.dart';
import 'package:rekrutacja_ai_native/presentation/order/bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetAiResponseUseCase getAIResponse;

  OrderBloc(this.getAIResponse) : super(OrderInitial()) {
    on<SendOrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final answer = await getAIResponse(event.prompt);
        emit(OrderSuccess(answer));
      } catch (e) {
        emit(OrderError(e.toString()));
      }
    });
  }
}
