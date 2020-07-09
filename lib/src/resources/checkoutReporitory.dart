import 'package:apos/src/models/models.dart';
import 'package:apos/src/resources/checkoutProvider.dart';

class CheckoutRepository{
  final CheckoutProvider checkoutProvider = new CheckoutProvider();

  Future createOrder(Sales sales,ListOrder listOrder) async{
    return await checkoutProvider.createOrder(sales, listOrder);
  }
}