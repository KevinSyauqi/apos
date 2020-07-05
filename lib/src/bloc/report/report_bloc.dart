import 'dart:async';
import 'package:apos/src/bloc/history/history_event.dart';
import 'package:apos/src/bloc/history/history_state.dart';
import 'package:apos/src/bloc/report/report_event.dart';
import 'package:apos/src/bloc/report/report_state.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';


class ReportBloc extends Bloc<ReportEvent, ReportState>{
  @override
  // TODO: implement initialState
  ReportState get initialState => throw UnimplementedError();

  @override
  Stream<ReportState> mapEventToState(ReportEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}

