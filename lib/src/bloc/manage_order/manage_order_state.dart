import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ManageOrderState {}

class ManageOrderInitialized extends ManageOrderState {}

class ManageOrderEmpty extends ManageOrderState {}

class ManageOrderLoading extends ManageOrderState {}

class ManageOrderError extends ManageOrderState {}

class ManageOrderLoaded extends ManageOrderState {
  final List<Menu> foods;
  final List<Menu> drinks;
  final List<int> foodMenuCounter;
  final List<int> drinkMenuCounter;

  ManageOrderLoaded({this.foods, this.drinks, this.foodMenuCounter, this.drinkMenuCounter});
}

class OrderError extends ManageOrderState{}

class OrderCount extends ManageOrderState{
  final List orderCount;
  OrderCount({this.orderCount});
}