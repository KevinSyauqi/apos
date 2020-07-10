import 'package:apos/src/models/models.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryFailure extends HistoryState {}

class HistoryEmpty extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Sales> listSales;

  HistoryLoaded({this.listSales});
}