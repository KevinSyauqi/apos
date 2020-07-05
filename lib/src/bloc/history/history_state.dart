import 'package:apos/src/models/outletModels.dart';
import 'package:equatable/equatable.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

// class HistoryLoaded extends HistoryState {
//   final History outlet;
//   HistoryLoaded({this.outlet});
// }

// class HistoryListLoaded extends HistoryState{
//   final List<History> outlets;
//   HistoryListLoaded({this.outlets});
// }

class HistoryFailure extends HistoryState {}

class HistoryEmpty extends HistoryState {}

class AddHistoryInitial extends HistoryState {}

class AddHistoryLoading extends HistoryState {}

class AddHistoryFailed extends HistoryState {
  final String message;
  AddHistoryFailed({this.message});
}

class AddHistorySuccess extends HistoryState {}