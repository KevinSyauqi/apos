import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ManageStockState {}

class ManageStockInitialized extends ManageStockState {}

class ManageStockEmpty extends ManageStockState {}

class ManageStockLoading extends ManageStockState {}

class ManageStockError extends ManageStockState {}

class ManageStockLoaded extends ManageStockState {
  final List<Menu> foods;
  final List<Menu> drinks;
  final List<int> foodMenuCounter;
  final List<int> drinkMenuCounter;

  ManageStockLoaded({this.foods, this.drinks, this.foodMenuCounter, this.drinkMenuCounter});
}

class StockError extends ManageStockState{}

class StockCount extends ManageStockState{
  final List stockCount;
  StockCount({this.stockCount});
}