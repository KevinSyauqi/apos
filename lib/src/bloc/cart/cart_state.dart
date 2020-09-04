
import 'package:apos/src/models/models.dart';

abstract class CartState {}

class CartInitialized extends CartState{}

class CartLoading extends CartState{}

class CartLoaded extends CartState{
  final List<OrderItem> cart;
  final List<Menu> menus;
  final int totalPrice;

  CartLoaded({this.cart, this.menus, this.totalPrice});
}

class CartError extends CartState{
  final message;

  CartError(this.message);
}

class CheckoutSuccess extends CartState{}

class CheckoutInProgress extends CartState{}