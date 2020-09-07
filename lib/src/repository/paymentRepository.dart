import 'package:apos/src/models/models.dart';
import 'package:apos/src/provider/paymentProvider.dart';

class PaymentRepository{
  final PaymentProvider paymentProvider = new PaymentProvider();

  Future createPayment(Order order, int cash, int change_amount) async{
    return await paymentProvider.createPayment(order, cash, change_amount);
  }

  Future getListOrderItemPayment(String id_order) async{
    return await paymentProvider.getListOrderItem(id_order);
  }

}