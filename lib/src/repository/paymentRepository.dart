import 'package:apos/src/models/models.dart';
import 'package:apos/src/provider/paymentProvider.dart';

class PaymentRepository{
  final PaymentProvider manageOrderProvider = new PaymentProvider();

  Future createPayment(Order order) async{
    return await manageOrderProvider.createPayment(order);
  }

}