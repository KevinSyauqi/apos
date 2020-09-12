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
        DateTime dateNow = event.end_date;
        DateTime startDate;
        switch (dateNow.weekday) {
          case DateTime.monday:
            {
              startDate = dateNow.subtract(new Duration(days: 6));
            }
            break;
          case DateTime.tuesday:
            {
              startDate = dateNow;
            }
            break;
          case DateTime.wednesday:
            {
              startDate = dateNow.subtract(new Duration(days: 1));
            }
            break;
          case DateTime.thursday:
            {
              startDate = dateNow.subtract(new Duration(days: 2));
            }
            break;
          case DateTime.friday:
            {
              startDate = dateNow.subtract(new Duration(days: 3));
            }
            break;
          case DateTime.saturday:
            {
              startDate = dateNow.subtract(new Duration(days: 4));
            }
            break;
          case DateTime.sunday:
            {
              startDate = dateNow.subtract(new Duration(days: 5));
            }
            break;
        }

        String totalSales;
        String totalIncome;
        String totalProfit;

        var response = await _reportRepository.getReportSummary(
            DateFormat('yyyy-MM-dd').format(startDate),
            DateFormat('yyyy-MM-dd').format(dateNow));
        if (response["success"] == true) {
          totalSales = response["data"]["totalSales"][0]["quantity"].toString();
          totalIncome = response["data"]["totalIncome"][0]["income"].toString();
          totalProfit = response["data"]["totalProfit"][0]["profit"].toString();
          var best5foodsales = _parsedFromJson(response["data"], "best5FoodSales");
          var best5drinksales = _parsedFromJson(response["data"], "best5DrinkSales");
          var lowest5foodsales = _parsedFromJson(response["data"], "lowest5foodSales");
          var lowest5drinksales = _parsedFromJson(response["data"], "lowest5drinkSales");

          yield
          ReportLoaded(
              totalIncome: totalIncome,
              totalSalesMenu: totalSales,
              totalProfit: totalProfit,
              best5foodsales: best5foodsales,
          best5drinksales: best5drinksales,
          lowest5foodsales: lowest5foodsales,
          lowest5drinksales: lowest5drinksales);
        } else
          yield ReportFailure();
      }
    } catch (e) {
      print(e);
      yield ReportFailure();
    }
  }

  ListOrderItem _parsedFromJson(Map<String, dynamic> json,String child) {
    ListOrderItem listOrderItem = new ListOrderItem(new List<OrderItem>());
    if (json['$child'] != null) {
      listOrderItem.listOrderItem = new List<OrderItem>();
      json['$child'].forEach((v) {
        listOrderItem.listOrderItem.add(new OrderItem.fromJson(v));
      });
    }
    return listOrderItem;
  }
}
