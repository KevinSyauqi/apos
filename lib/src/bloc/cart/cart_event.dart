
import 'package:apos/src/models/models.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent{}

class AddToCart extends CartEvent{
  final Menu menu;

  AddToCart({this.menu});
}

class RemoveFromCart extends CartEvent{
  final Menu menu;

  RemoveFromCart({this.menu});
}

class CheckoutCart extends CartEvent{
  final List<OrderItem> listOrderItem;
  final List<Menu> orders;
  final int totalPrice;

  CheckoutCart({this.listOrderItem, this.orders, this.totalPrice});
}

class PayLater extends CartEvent{
  final List<OrderItem> listOrderItem;
  final int totalPrice;

  PayLater({this.listOrderItem, this.totalPrice});
}

class CheckoutDispose extends CartEvent{}

class PayNow extends CartEvent{
  final List<Menu> listMenu;
  final List<OrderItem> listOrderItem;
  final int totalPrice;

  PayNow({this.listMenu,this.listOrderItem, this.totalPrice});
}