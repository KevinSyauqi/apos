import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CheckoutCartState {}

class CheckoutInitial extends CheckoutCartState {}

class CheckoutLoading extends CheckoutCartState {}

class CheckoutLoaded extends CheckoutCartState {}

class CheckoutFailure extends CheckoutCartState {}

class CheckoutFinish extends CheckoutCartState {}

class CreateOrderLoading extends CheckoutCartState {}

class CreateOrderSuccess extends CheckoutCartState {
  final Order order;
  final ListOrderItem listOrderItem;

  CreateOrderSuccess({this.order, this.listOrderItem});
}

class AddToOrderSuccess extends CheckoutCartState {
  final Order order;
  final ListOrderItem listOrderItem;

  AddToOrderSuccess({this.order, this.listOrderItem});
}

class CreateOrderFailure extends CheckoutCartState{
  final message;

  CreateOrderFailure({this.message});

}

class ClearOrder extends CheckoutCartState {
  final ListOrderItem listOrderItem;

  ClearOrder({this.listOrderItem});
}