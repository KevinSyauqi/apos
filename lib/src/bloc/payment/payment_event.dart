import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PaymentEvent {}

class createPayment extends PaymentEvent {
  Order order;

  createPayment({this.order});
}
