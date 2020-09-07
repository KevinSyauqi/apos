import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PaymentState {}

class InitialPaymentState extends PaymentState {}

class PaymentInProcess extends PaymentState {}

class PaymentSuccess extends PaymentState {
  Sales sales;
  Order order;
  Payment payment;
  ListOrderItem listOrderItem;

  PaymentSuccess({this.sales, this.order, this.payment, this.listOrderItem});
}

class PaymentFailure extends PaymentState {
  String error;

  PaymentFailure({this.error});
}

class PaymentLoaded extends PaymentState {
  Order order;

  PaymentLoaded({this.order});
}
