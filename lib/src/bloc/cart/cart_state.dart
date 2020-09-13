
import 'package:apos/src/models/models.dart';

abstract class CartState {}

class CartInitialized extends CartState{}

class CartLoading extends CartState{}

class CartLoaded extends CartState{
  final String id_order;
  final List<OrderItem> cart;
  final List<Menu> menus;
  final int totalPrice;

  CartLoaded({this.id_order,this.cart, this.menus, this.totalPrice});
}

class CartError extends CartState{
  final message;

  CartError(this.message);
}

class CheckoutSuccess extends CartState{}

class CheckoutInProgress extends CartState{}