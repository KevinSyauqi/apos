import 'package:apos/src/models/models.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryFailure extends HistoryState {}

class HistoryEmpty extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Sales> listSales;
  final List<String> customers_name;

  HistoryLoaded({this.listSales, this.customers_name});
}

class DetailHistoryLoading extends HistoryState {}
class DetailHistoryLoaded extends HistoryState {
  final Sales sales;
  final Order order;
  final Payment payment;
  final List<OrderItem> listOrderItem;

  DetailHistoryLoaded({this.sales, this.order, this.payment, this.listOrderItem});
}
class DetailHIstoryFailure extends HistoryState {}