
import 'package:apos/src/models/models.dart';

abstract class ManageStockEvent {}

class StockOrder extends ManageStockEvent {
  final String username;
  final String password;

  StockOrder({this.username, this.password});
}

class FetchStockMenus extends ManageStockEvent{}

// class StockButtonPressed extends ManageStockEvent{
//   ListOrder listOrder;
//   Sales sales;

//   CheckoutButtonPressed({this.listOrder, this.sales});
// }

class StockMenuIncrement extends ManageStockEvent{
  int index;
}

class StockMenuDecrement extends ManageStockEvent{
  int index;
}
