import 'package:meta/meta.dart';

@immutable
abstract class CheckoutOrderEvent {}

class fetchOrderDetail extends CheckoutOrderEvent {
  String id_order;

  fetchOrderDetail({this.id_order});
}