import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CheckoutOrderState {}

class InitialCheckoutOrdeState extends CheckoutOrderState {}

class CheckoutOrderLoading extends CheckoutOrderState {}

class CheckoutOrderLoaded extends CheckoutOrderState {
  Order order;
  ListOrderItem listOrderItem;

  CheckoutOrderLoaded({this.order, this.listOrderItem});
}

class CheckoutOrderFailure extends CheckoutOrderState {}
