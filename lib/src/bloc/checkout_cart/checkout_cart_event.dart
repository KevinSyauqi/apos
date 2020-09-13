import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

abstract class CheckoutCartEvent {}

class CreateOrderButtonPressed extends CheckoutCartEvent{
  List<OrderItem> cart;
  String customerName;
  int tableNumber;
  int totalPrice;

  CreateOrderButtonPressed({this.cart, this.customerName, this.tableNumber, this.totalPrice});
}

class AddToOrderButtonPressed extends CheckoutCartEvent{
  String id_order;
  List<OrderItem> cart;
  String customerName;
  int tableNumber;
  int totalPrice;

  AddToOrderButtonPressed({this.id_order,this.cart, this.customerName, this.tableNumber, this.totalPrice});
}