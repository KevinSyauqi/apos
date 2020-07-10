import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TransactionMenuState {}

class TrscMenuInitialized extends TransactionMenuState {}

class TrscMenuEmpty extends TransactionMenuState {}

class TrscMenuLoading extends TransactionMenuState {}

class TrscMenuError extends TransactionMenuState {}

class TrscMenuLoaded extends TransactionMenuState {
  final List<Menu> foods;
  final List<Menu> drinks;
  final List<int> foodMenuCounter;
  final List<int> drinkMenuCounter;

  TrscMenuLoaded({this.foods, this.drinks, this.foodMenuCounter, this.drinkMenuCounter});
}

class TrscError extends TransactionMenuState{}

class TsrcError extends TransactionMenuState{}

class OrderCount extends TransactionMenuState{
  final List orderCount;
  OrderCount({this.orderCount});
}