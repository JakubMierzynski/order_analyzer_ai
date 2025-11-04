import 'package:rekrutacja_ai_native/domain/entities/order_result.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final OrderResult answer;
  OrderSuccess(this.answer);
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}
