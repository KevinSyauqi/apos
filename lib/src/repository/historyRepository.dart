import 'package:apos/src/models/models.dart';
import 'package:apos/src/provider/historyProvider.dart';

class HistoryRepository{
  final HistoryProvider historyProvider = new HistoryProvider();

  Future<List<Sales>> getAllOutletSales(String id_outlet) async{
    return await historyProvider.getAllOutletSales(id_outlet);
  }
}