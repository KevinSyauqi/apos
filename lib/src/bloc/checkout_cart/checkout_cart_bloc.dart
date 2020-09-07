import 'dart:async';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/manageOrderRepository.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class CheckoutCartBloc extends Bloc<CheckoutCartEvent, CheckoutCartState> {
  final ManageOrderRepository _manageOrderRepository = new ManageOrderRepository();

  @override
  CheckoutCartState get initialState => CheckoutInitial();

  @override
  Stream<CheckoutCartState> mapEventToState(CheckoutCartEvent event) async* {
    if(event is CreateOrderButtonPressed){
        yield CreateOrderLoading();
        Order order = new Order("S001U001",event.tableNumber,event.customerName,event.totalPrice);
        ListOrderItem cart = new ListOrderItem(event.cart);

        final response = await _manageOrderRepository.createOrder(order, cart);
        if(response["success"] == true){
          yield CreateOrderSuccess(order: order, listOrderItem: cart);
        } else{
          yield CreateOrderFailure(message: response["messsage"].toString());
        }
      }
  }
}
