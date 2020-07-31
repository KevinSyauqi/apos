import 'dart:async';
import 'package:apos/src/bloc/report/report_event.dart';
import 'package:apos/src/bloc/report/report_state.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/resources/ReportRepository.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';


class ReportBloc extends Bloc<ReportEvent, ReportState>{
  ReportRepository _reportRepository = ReportRepository();

  @override
  // TODO: implement initialState
  ReportState get initialState => ReportInitial();

  @override
  Stream<ReportState> mapEventToState(ReportEvent event) async* {
    if(event is GetReportSalesByDate){
      List<SalesLineItem> sales;
      sales = await _reportRepository.getReportSales(event.id_outlet_menu, event.startDate, event.endDate);
      if(sales.length != 0){
        yield ReportLoaded(reportSales: sales);
      } else yield ReportEmpty();
    }
  }

}

