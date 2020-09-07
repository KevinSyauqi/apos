import 'dart:async';
import 'dart:convert';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/manageOrderRepository.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class ActiveOrderBloc extends Bloc<ActiveOrderEvent, ActiveOrderState> {
  ManageOrderRepository _manageOrderRepository = ManageOrderRepository();

  @override
  ActiveOrderState get initialState => ActiveOrderInitial();

  @override
  Stream<ActiveOrderState> mapEventToState(ActiveOrderEvent event) async* {
    if(event is fetchListOrder){
      yield ActiveOrderLoading();
      final response = await _manageOrderRepository.fetchListOrder();
      if(response["success"] == true){
        List<Order> data = parsedListResponse(response);
        ListOrder listOrder = new ListOrder(data);
        yield ActiveOrderLoaded(listOrder: listOrder);
      }else{
        yield ActiveOrderFailure();
      }
    }
  }

  List<Order> parsedListResponse(final response) {
    if (response["success"] == true) {
      return ListOrder.fromJson(response).listOrder;
    } else {
      throw Exception('Failed to load listOrder');
    }
  }
}
