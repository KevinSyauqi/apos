abstract class ReportEvent {}

class GetReportSalesByDate extends ReportEvent{
  final String id_outlet_menu;
  final String startDate;
  final String endDate;

  GetReportSalesByDate({this.id_outlet_menu, this.startDate, this.endDate});
}