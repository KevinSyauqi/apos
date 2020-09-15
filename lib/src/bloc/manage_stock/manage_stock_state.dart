import 'package:apos/src/models/menuModels.dart';

abstract class ManageStockState {}

class ManageStockInitialized extends ManageStockState {}

class ManageStockEmpty extends ManageStockState {}

class ManageStockLoading extends ManageStockState {}

class ManageStockError extends ManageStockState {}

class ManageStockLoaded extends ManageStockState {
  final List<Menu> foods;
  final List<Menu> drinks;


  ManageStockLoaded({this.foods, this.drinks});
}

class StockCount extends ManageStockState{
  final List stockCount;
  StockCount({this.stockCount});
}