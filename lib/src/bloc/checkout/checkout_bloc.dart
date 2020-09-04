import 'dart:async';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  @override
  CheckoutState get initialState => CheckoutInitial();

  @override
  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {
//    if (event is PayLater) {
//      yield CheckoutInProgress();
//      Order order;
//      ListOrder listOrder = new ListOrder([]);
//
//      order = new Order("S001U001", 2, "puput", event.totalPrice);
////      listOrder.listOrder = event.listOrderItem;
//      final response = await _checkoutRepository.createOrder(order, listOrder);
//      final bool success = response['success'];
//      if (success) {
//        yield CheckoutSuccess();
//      } else {
//        yield CartError(response['message']);
//        print(response['message']);
//      }
//    }
  }
}
