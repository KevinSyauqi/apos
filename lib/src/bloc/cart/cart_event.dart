
import 'package:apos/src/models/models.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent{
  final String id_order;

  LoadCart({this.id_order});
}

class LoadCurrentOrderCart extends CartEvent{}

class AddToCart extends CartEvent{
  String id_order;
  final Menu menu;

  AddToCart({this.id_order,this.menu});
}

class RemoveFromCart extends CartEvent{
  String id_order;
  final Menu menu;

  RemoveFromCart({this.id_order,this.menu});
}

class CheckoutCart extends CartEvent{
  final List<OrderItem> listOrderItem;
  final List<Menu> orderMenus;
  final int totalPrice;
  final String id_order;

  CheckoutCart({this.id_order,this.listOrderItem, this.orderMenus, this.totalPrice});
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