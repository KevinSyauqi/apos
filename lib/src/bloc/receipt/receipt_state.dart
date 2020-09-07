import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ReceiptState {}

class InitialReceiptState extends ReceiptState {}

class ReceiptLoading extends ReceiptState {}

class ReceiptLoaded extends ReceiptState {
  Sales sales;
  Order order;
  Payment payment;
  ListOrderItem listOrderItem;

  ReceiptLoaded({this.sales, this.order, this.payment, this.listOrderItem});
}

class ReceiptFailure extends ReceiptState {}