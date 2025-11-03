abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final String answer;
  OrderSuccess(this.answer);
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}
