import 'dart:async';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/paymentRepository.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentRepository _paymentRepository = new PaymentRepository();

  @override
  PaymentState get initialState => InitialPaymentState();

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    try{
      if(event is createPayment){
        yield PaymentInProcess();
        Order order = event.order;
        int cash = event.cash;
        if(cash >= order.total_price) {
          order.id_user = "S001U001";
          int change_amount = cash - order.total_price;

          final response = await _paymentRepository.createPayment(
              order, cash, change_amount);
          if(response["success"] == true){
            ListOrderItem listOrderItem;
            final data = response["data"];
            Sales sales = Sales.fromJson(data["sales"]);
            Payment payment = Payment.fromJson(data["payment"]);
            final responseOrderItem = await _paymentRepository.getListOrderItemPayment(event.order.id_order);
            if(responseOrderItem["success"] == true){
              final dataJson = responseOrderItem["data"];
              listOrderItem = _parsedFromJson(dataJson);
              print("Isi" + listOrderItem.listOrderItem.length.toString());
            }
            yield PaymentSuccess(sales: sales, payment: payment, order: event.order, listOrderItem: listOrderItem);
          } else{
            yield PaymentFailure(error: response["message"]);
          }
        } else{
          yield PaymentFailure(error: "Nominal bayar kurang dari total bayar");
        }

      }
      if(event is fetchOrder){
        yield PaymentLoaded(order: event.order);
      }
    }catch(e){
      print(e);
      yield PaymentFailure(error: e.toString());
    }

  }

  ListOrderItem _parsedFromJson(Map<String, dynamic> json) {
    ListOrderItem listOrderItem = new ListOrderItem(new List<OrderItem>());
    if (json['listOrderItem'] != null) {
      listOrderItem.listOrderItem = new List<OrderItem>();
      json['listOrderItem'].forEach((v) {
        listOrderItem.listOrderItem.add(new OrderItem.fromJson(v));
      });
    }
    return listOrderItem;
  }
}
