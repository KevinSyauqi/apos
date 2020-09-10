import 'package:apos/src/models/models.dart';
import 'package:apos/src/provider/manageOrderProvider.dart';
import 'package:apos/src/provider/manageStockProvider.dart';

class ManageStockRepository{
  final ManageStockProvider manageStockProvider = new ManageStockProvider();


  Future<List<Menu>> fetchAllMenu() async{
    return await manageStockProvider.fetchAllMenu();
  }



}