import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  @override
  EmployeeState get initialState => InitialEmployeeState();

  @override
  Stream<EmployeeState> mapEventToState(
    EmployeeEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
