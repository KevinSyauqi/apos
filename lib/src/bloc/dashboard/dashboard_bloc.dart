import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:apos/src/bloc/bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  @override
  DashboardState get initialState => InitialDashboardState();

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
