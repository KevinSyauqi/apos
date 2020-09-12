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
  final DateTime startDate;
  final DateTime endDate;

  ReportLoaded({this.totalIncome, this.totalSalesMenu, this.totalProfit, this.best5foodsales,
  this.best5drinksales, this.lowest5drinksales, this.lowest5foodsales, this.startDate, this.endDate});
}

class ReportDetailLoaded extends ReportState{
  final List<Report> listReport;
  final DateTime startDate;
  final DateTime endDate;

  ReportDetailLoaded({this.listReport, this.startDate, this.endDate});
}

class ReportDetailLoading extends ReportState{}

class ReportDetailFailure extends ReportState{}