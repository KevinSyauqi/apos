import 'dart:async';
import 'package:apos/src/bloc/history/history_event.dart';
import 'package:apos/src/bloc/history/history_state.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';


class HistoryBloc extends Bloc<HistoryEvent, HistoryState>{
  @override
  // TODO: implement initialState
  HistoryState get initialState => throw UnimplementedError();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}

