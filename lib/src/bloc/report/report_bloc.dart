import 'dart:async';

import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/reportRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:apos/src/bloc/bloc.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportRepository _reportRepository = ReportRepository();

  @override
  // TODO: implement initialState
  ReportState get initialState => ReportInitial();

  @override
  Stream<ReportState> mapEventToState(ReportEvent event) async* {
    try {
      if (event is GenerateReportSales) {
        yield ReportLoading();
        DateTime startDate;
        DateTime endDate;
        if (event.start_date == null) {
          endDate = event.end_date;
          switch (endDate.weekday) {
            case DateTime.monday:
              {
                startDate = endDate.subtract(new Duration(days: 6));
              }
              break;
            case DateTime.tuesday:
              {
                startDate = endDate;
              }
              break;
            case DateTime.wednesday:
              {
                startDate = endDate.subtract(new Duration(days: 1));
              }
              break;
            case DateTime.thursday:
              {
                startDate = endDate.subtract(new Duration(days: 2));
              }
              break;
            case DateTime.friday:
              {
                startDate = endDate.subtract(new Duration(days: 3));
              }
              break;
            case DateTime.saturday:
              {
                startDate = endDate.subtract(new Duration(days: 4));
              }
              break;
            case DateTime.sunday:
              {
                startDate = endDate.subtract(new Duration(days: 5));
              }
              break;
          }
        } else {
          startDate = event.start_date;
          endDate = event.end_date;
        }

        String totalSales;
        String totalIncome;
        String totalProfit;

        var response = await _reportRepository.getReportSummary(
            DateFormat('yyyy-MM-dd').format(startDate),
            DateFormat('yyyy-MM-dd').format(endDate));
        if (response["success"] == true) {
          if (response["data"] != null && response["data"] != "") {
            totalSales =
                response["data"]["totalSales"][0]["quantity"].toString();
            totalIncome =
                response["data"]["totalIncome"][0]["income"].toString();
            totalProfit =
                response["data"]["totalProfit"][0]["profit"].toString();
            var best5foodsales =
                _parsedFromJson(response["data"], "best5FoodSales");
            var best5drinksales =
                _parsedFromJson(response["data"], "best5DrinkSales");
            var lowest5foodsales =
                _parsedFromJson(response["data"], "lowest5foodSales");
            var lowest5drinksales =
                _parsedFromJson(response["data"], "lowest5drinkSales");

            var weeklyReportSales =
                _parsedFromJsonReport(response["data"], "dataSales");
            var weeklyReportProfit =
                _parsedFromJsonReport(response["data"], "dataProfit");
            var weeklyReportIncome =
                _parsedFromJsonReport(response["data"], "dataIncome");

            yield ReportLoaded(
                totalIncome: totalIncome,
                totalSalesMenu: totalSales,
                totalProfit: totalProfit,
                best5foodsales: best5foodsales,
                best5drinksales: best5drinksales,
                lowest5foodsales: lowest5foodsales,
                lowest5drinksales: lowest5drinksales,
                startDate: startDate,
                endDate: endDate,
                weeklyReportSales: weeklyReportSales,
                weeklyReportIncome: weeklyReportIncome,
                weeklyReportProfit: weeklyReportProfit);
          } else {
            yield ReportLoaded(
                totalIncome: "0",
                totalSalesMenu: "0",
                totalProfit: "0",
                best5foodsales: new ListOrderItem([]),
                best5drinksales: new ListOrderItem([]),
                lowest5foodsales: new ListOrderItem([]),
                lowest5drinksales: new ListOrderItem([]),
                startDate: startDate,
                endDate: endDate);
          }
        } else
          yield ReportFailure();
      }
      if (event is GetReportDetail) {
        yield ReportDetailLoading();

        final response = await _reportRepository.getReportDetail(
            DateFormat('yyyy-MM-dd').format(event.start_date),
            DateFormat('yyyy-MM-dd').format(event.end_date));
        if (response["success"] == true) {
          ListReport listReport = new ListReport([]);
          listReport = ListReport.fromJson(response);
          yield ReportDetailLoaded(
              listReport: listReport.listReport,
              startDate: event.start_date,
              endDate: event.end_date);
        } else {
          yield ReportDetailFailure();
        }
      }
    } catch (e) {
      print(e);
      yield ReportFailure();
    }
  }

  ListOrderItem _parsedFromJson(Map<String, dynamic> json, String child) {
    ListOrderItem listOrderItem = new ListOrderItem(new List<OrderItem>());
    if (json['$child'] != null) {
      listOrderItem.listOrderItem = new List<OrderItem>();
      json['$child'].forEach((v) {
        listOrderItem.listOrderItem.add(new OrderItem.fromJson(v));
      });
    }
    return listOrderItem;
  }

  List<Report> _parsedFromJsonReport(Map<String, dynamic> json, String child) {
    List<Report> listReport;
    if (json['$child'] != null) {
      listReport = new List<Report>();
      json['$child'].forEach((v) {
        listReport.add(new Report.fromJson(v));
      });
    }
    return listReport;
  }
}
