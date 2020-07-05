import 'package:apos/src/models/outletModels.dart';
import 'package:equatable/equatable.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

// class ReportLoaded extends ReportState {
//   final Report outlet;
//   ReportLoaded({this.outlet});
// }

// class ReportListLoaded extends ReportState{
//   final List<Report> outlets;
//   ReportListLoaded({this.outlets});
// }

class ReportFailure extends ReportState {}

class ReportEmpty extends ReportState {}

class AddReportInitial extends ReportState {}

class AddReportLoading extends ReportState {}

class AddReportFailed extends ReportState {
  final String message;
  AddReportFailed({this.message});
}

class AddReportSuccess extends ReportState {}