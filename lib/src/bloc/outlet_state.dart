import 'package:apos/src/models/outletModels.dart';
import 'package:equatable/equatable.dart';

abstract class OutletState extends Equatable {
  const OutletState();

  @override
  List<Object> get props => [];
}

class OutletInitial extends OutletState {}

class OutletLoading extends OutletState {}

class OutletLoaded extends OutletState {
  final Outlet outlet;
  OutletLoaded({this.outlet});
}

class OutletListLoaded extends OutletState{
  final List<Outlet> outlets;
  OutletListLoaded({this.outlets});
}

class OutletFailure extends OutletState {}

class OutletEmpty extends OutletState {}

