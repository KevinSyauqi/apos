
import 'package:apos/src/models/models.dart';

abstract class TransactionMenuEvent {}

class CreateOrder extends TransactionMenuEvent {
  final String username;
  final String password;

  CreateOrder({this.username, this.password});
}

class FetchMenus extends TransactionMenuEvent{}

class CheckoutButtonPressed extends TransactionMenuEvent{
  ListOrder listOrder;
  Sales sales;

  CheckoutButtonPressed({this.listOrder, this.sales});
}

class OrderMenuIncrement extends TransactionMenuEvent{
  int index;
}

class OrderMenuDecrement extends TransactionMenuEvent{
  int index;
}