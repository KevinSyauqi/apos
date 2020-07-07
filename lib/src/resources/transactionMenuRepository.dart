import 'package:apos/src/models/models.dart';
import 'package:apos/src/resources/transactionMenuProvider.dart';

class TransactionRepository{
  final TransactionMenuProvider trscMenuProvider = new TransactionMenuProvider();

  Future createOrder(ListOrder listOrder, Sales sales) async{
    return await trscMenuProvider.createOrder(listOrder, sales);
  }

  Future<List<Menu>> fetchMenus(String outlet) async{
    return await trscMenuProvider.fetchAllMenuOutlet(outlet);
  }

}