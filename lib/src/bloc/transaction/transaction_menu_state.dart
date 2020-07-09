import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TransactionMenuState {}

class TrscMenuInitialized extends TransactionMenuState {}

class TrscMenuEmpty extends TransactionMenuState {}

class TrscMenuLoading extends TransactionMenuState {}

class TrscMenuError extends TransactionMenuState {}

class TrscMenuLoaded extends TransactionMenuState {
  List<Menu> menus;
  TrscMenuLoaded({this.menus});
}

class TrscError extends TransactionMenuState{}

class TsrcError extends TransactionMenuState{}

class OrderCount extends TransactionMenuState{
  final List orderCount;
  OrderCount({this.orderCount});
}