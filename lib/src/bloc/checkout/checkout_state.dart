
import 'package:apos/src/models/models.dart';

abstract class CheckoutState {}

class CheckoutInitialized extends CheckoutState{}

class CheckoutLoading extends CheckoutState{}

class CheckoutLoaded extends CheckoutState{
  final List<SalesLineItem> listSalesLineItem;
  final List<Menu> menus;
  final int totalPrice;

  CheckoutLoaded({this.listSalesLineItem, this.menus, this.totalPrice});
}

class CheckoutError extends CheckoutState{}
