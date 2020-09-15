import 'package:apos/src/models/models.dart';
import 'package:apos/src/provider/manageStockProvider.dart';

class ManageStockRepository{
  final ManageStockProvider manageStockProvider = new ManageStockProvider();


  Future<List<Menu>> fetchAllStock() async{
    return await manageStockProvider.fetchAllStock();
  }

  Future addStock(String id_menu, int quantity_stock) async{
    return await manageStockProvider.updateStock(id_menu, quantity_stock);
  }

  Future removeStock(String id_menu, int quantity_stock) async{
    return await manageStockProvider.updateStock(id_menu, quantity_stock);
  }
}