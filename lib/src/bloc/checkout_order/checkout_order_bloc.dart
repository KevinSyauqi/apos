import 'dart:async';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/manageOrderRepository.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class CheckoutOrderBloc extends Bloc<CheckoutOrderEvent, CheckoutOrderState> {
  ManageOrderRepository _manageOrderRepository = ManageOrderRepository();

  @override
  CheckoutOrderState get initialState => InitialCheckoutOrdeState();

  @override
  Stream<CheckoutOrderState> mapEventToState(CheckoutOrderEvent event) async* {
    if(event is fetchOrderDetail){
      yield CheckoutOrderLoading();

      final response = await _manageOrderRepository.fetchOrderDetail(event.id_order);
      if(response["success"] == true){

        final dataJson = response["data"];

        Order order = Order.fromJson(dataJson["order"]);
        ListOrderItem listOrderItem = _parsedFromJson(dataJson);

        yield CheckoutOrderLoaded(order: order, listOrderItem: listOrderItem);
      }else{
        yield CheckoutOrderFailure();
      }
    }
    if(event is getOrder){
      yield CheckoutOrderLoading();
      yield CheckoutOrderLoaded(order: event.order);
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
