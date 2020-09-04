import 'package:apos/src/models/models.dart';
import 'package:apos/src/provider/checkoutProvider.dart';

class CheckoutRepository{
  final CheckoutProvider checkoutProvider = new CheckoutProvider();

  Future createOrder(Order order,ListOrder listOrder) async{
    return await checkoutProvider.createOrder(order, listOrder);
  }
}