import 'package:apos/src/models/models.dart';
import 'package:apos/src/provider/manageOrderProvider.dart';

class manageOrderRepository{
  final manageOrderProvider trscMenuProvider = new manageOrderProvider();

  Future createOrder(ListOrder listOrder, Sales sales) async{
    return await trscMenuProvider.createOrder(listOrder, sales);
  }

  Future<List<Menu>> fetchAllMenu() async{
    return await trscMenuProvider.fetchAllMenu();
  }

}