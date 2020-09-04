import 'package:apos/src/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportFailure extends ReportState {}

class ReportEmpty extends ReportState {}

class ReportLoaded extends ReportState {
  final List<OrderItem> reportSales;

  ReportLoaded({this.reportSales});
}