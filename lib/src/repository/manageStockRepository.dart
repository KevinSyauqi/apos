import 'package:apos/src/models/models.dart';
import 'package:apos/src/provider/manageStockProvider.dart';

class ManageStockRepository{
  final ManageStockProvider manageStockProvider = new ManageStockProvider();


  Future<List<Menu>> fetchAllStock() async{
    return await manageStockProvider.fetchAllStock();
  }



}