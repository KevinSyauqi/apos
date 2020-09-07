import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PaymentEvent {}

class createPayment extends PaymentEvent {
  Order order;
  int cash;

  createPayment({this.order,this.cash});
}

class fetchOrder extends PaymentEvent {
  Order order;

  fetchOrder({this.order});
}

class getListOrderItemPayment extends PaymentEvent{
  String id_order;

  getListOrderItemPayment({this.id_order});
}
