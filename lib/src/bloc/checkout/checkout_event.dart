
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

class CheckoutPressed extends CheckoutEvent{
  final List<Menu> order;

  CheckoutPressed({this.order});
}