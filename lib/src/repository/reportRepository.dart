import 'package:apos/src/provider/reportProvider.dart';

class ReportRepository {
  ReportProvider _reportProvider = ReportProvider();

  Future getReportSummary(String start_date, String end_date) async {
    return await _reportProvider.getReportSummary(start_date, end_date);
  }

  Future getReportDetail(String start_date, String end_date) async {
    return await _reportProvider.getReportDetail(start_date, end_date);
  }
}
