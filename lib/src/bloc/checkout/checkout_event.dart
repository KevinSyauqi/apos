
import 'package:apos/src/models/models.dart';

abstract class CheckoutEvent {}

class LoadCart extends CheckoutEvent{}

class AddCheckout extends CheckoutEvent{
  final Menu menu;

  AddCheckout({this.menu});
}

class RemoveFromCheckout extends CheckoutEvent{
  final Menu menu;

  RemoveFromCheckout({this.menu});
}

class CheckoutCart extends CheckoutEvent{
  final List<SalesLineItem> listSalesLineItem;
  final List<Menu> orders;
  final int totalPrice;

  CheckoutCart({this.listSalesLineItem, this.orders, this.totalPrice});
}

class PayLater extends CheckoutEvent{
  final List<SalesLineItem> listSalesLineItem;
  final int totalPrice;

  PayLater({this.listSalesLineItem, this.totalPrice});
}

class CheckoutDispose extends CheckoutEvent{}

class PayNow extends CheckoutEvent{
  final List<Menu> listMenu;
  final List<SalesLineItem> listSalesLineItem;
  final int totalPrice;

  PayNow({this.listMenu,this.listSalesLineItem, this.totalPrice});
}