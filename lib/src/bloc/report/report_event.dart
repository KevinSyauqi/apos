abstract class ReportEvent {}

class GetReportSalesByDate extends ReportEvent{
  final String id_outlet_menu;
  final String startDate;
  final String endDate;

  GetReportSalesByDate({this.id_outlet_menu, this.startDate, this.endDate});
}

class GenerateReportSales extends ReportEvent{
  final DateTime start_date;
  final DateTime end_date;

  GenerateReportSales({this.start_date, this.end_date});
}

class GetReportDetail extends ReportEvent{
  final DateTime start_date;
  final DateTime end_date;

  GetReportDetail({this.start_date, this.end_date});
}