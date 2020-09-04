
import 'package:apos/src/models/models.dart';

abstract class ManageOrderEvent {}

class CreateOrder extends ManageOrderEvent {
  final String username;
  final String password;

  CreateOrder({this.username, this.password});
}

class FetchMenus extends ManageOrderEvent{}

class CheckoutButtonPressed extends ManageOrderEvent{
  ListOrder listOrder;
  Sales sales;

  CheckoutButtonPressed({this.listOrder, this.sales});
}

class OrderMenuIncrement extends ManageOrderEvent{
  int index;
}

class OrderMenuDecrement extends ManageOrderEvent{
  int index;
}