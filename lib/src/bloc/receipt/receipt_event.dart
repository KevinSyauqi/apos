import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ReceiptEvent {}

class getReceipt extends ReceiptEvent {
  Sales sales;
  Order order;
  Payment payment;
  ListOrderItem listOrderItem;

  getReceipt({this.sales, this.order, this.payment, this.listOrderItem});
}

