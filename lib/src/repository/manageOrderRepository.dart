import 'package:apos/src/models/models.dart';
import 'package:apos/src/provider/manageOrderProvider.dart';

class ManageOrderRepository{
  final ManageOrderProvider manageOrderProvider = new ManageOrderProvider();

  Future createOrder(Order order, ListOrderItem listOrderItem) async{
    return await manageOrderProvider.createOrder(order, listOrderItem);
  }

  Future<List<Menu>> fetchAllMenu() async{
    return await manageOrderProvider.fetchAllMenu();
  }

  Future fetchListOrder() async{
    return await manageOrderProvider.fetchListOrder();
  }

  Future fetchOrderDetail(String id_order) async{
    return await manageOrderProvider.fetchOrderDetail(id_order);
  }

}