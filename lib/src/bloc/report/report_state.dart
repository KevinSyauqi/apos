import 'package:apos/src/models/models.dart';

abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportFailure extends ReportState {}

class ReportEmpty extends ReportState {}

class ReportLoaded extends ReportState {
  final String totalIncome;
  final String totalSalesMenu;
  final String totalProfit;
  final ListOrderItem best5foodsales;
  final ListOrderItem best5drinksales;
  final ListOrderItem lowest5foodsales;
  final ListOrderItem lowest5drinksales;

  ReportLoaded({this.totalIncome, this.totalSalesMenu, this.totalProfit, this.best5foodsales,
  this.best5drinksales, this.lowest5drinksales, this.lowest5foodsales});
}