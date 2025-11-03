abstract class OrderEvent {}

class SendOrderEvent extends OrderEvent {
  final String prompt;

  SendOrderEvent(this.prompt);
}