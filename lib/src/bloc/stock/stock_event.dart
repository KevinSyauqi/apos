class StockEvent {}

class AddStock extends StockEvent {
  final String id_menu;
  final int quantity_stock;

  AddStock({this.id_menu, this.quantity_stock});
}

class RemoveStock extends StockEvent {
  final String id_menu;
  final int quantity_stock;

  RemoveStock({this.id_menu, this.quantity_stock});
}

class ReloadStock extends StockEvent{}