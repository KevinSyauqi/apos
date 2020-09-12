import 'package:apos/src/models/models.dart';
import 'package:apos/src/provider/historyProvider.dart';

class HistoryRepository{
  final HistoryProvider historyProvider = new HistoryProvider();

  Future getSalesHistory() async{
    return await historyProvider.getSalesHistory();
  }

  Future getDetailSalesHistory(String id_sale) async{
    return await historyProvider.getDetailSalesHistory(id_sale);
  }
}