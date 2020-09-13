class ManageStockEvent {}

class FetchingAllStock extends ManageStockEvent{}

class StockMenuIncrement extends ManageStockEvent{
  int index;
}

class StockMenuDecrement extends ManageStockEvent{
  int index;
}
