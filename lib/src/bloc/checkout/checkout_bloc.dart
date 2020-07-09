import 'dart:async';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/models/salesLineItemModels.dart';
import 'package:apos/src/resources/checkoutReporitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apos/src/bloc/bloc.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutRepository _checkoutRepository = new CheckoutRepository();

  @override
  CheckoutState get initialState => CheckoutInitialized();

  @override
  Stream<CheckoutState> mapEventToState(
    CheckoutEvent event,
  ) async* {
    if (event is LoadCart) {
      yield CheckoutLoading();
      try {
        yield CheckoutLoaded(listSalesLineItem: [], menus: [], totalPrice: 0);
      } catch (e) {
        print(e);
        yield CheckoutError(e);
      }
    }
    if (event is AddCheckout) {
      final currentState = state;
      if (currentState is CheckoutLoaded) {
        try {
          yield CheckoutLoaded(
              menus: List.from(currentState.menus)..add(event.menu),
              totalPrice: currentState.totalPrice + event.menu.price);
        } catch (e) {
          print(e);
          yield CheckoutError(e);
        }
      }
    }
    if (event is RemoveFromCheckout) {
      final currentState = state;
      if (currentState is CheckoutLoaded) {
        try {
          yield CheckoutLoaded(
              menus: List.from(currentState.menus)..remove(event.menu),
              totalPrice: currentState.totalPrice - event.menu.price);
        } catch (e) {
          print(e);
          yield CheckoutError(e);
        }
      }
    }
    if (event is CheckoutCart) {
      try {
        List<SalesLineItem> listOrder;
        SalesLineItem order;
        listOrder = [];
        event.orders.forEach((menu) {
          if (listOrder.any((item) => item.id_outlet_menu == menu.id_outlet_menu)) {
            final index = listOrder.indexWhere((item) => item.id_outlet_menu == menu.id_outlet_menu);
            listOrder[index].qty++;
            listOrder[index].subtotal_price = listOrder[index].subtotal_price + menu.price;
            print("Masuk sini ih");
            print(listOrder[index].toJson().toString());
          } else {
            order = new SalesLineItem(menu.id_outlet_menu, 1, menu.price, 0);
            print(order.toJson().toString());
            listOrder.add(order);
          }
        });
        print(listOrder.length);
        yield CheckoutLoaded(
            listSalesLineItem: listOrder,
            menus: event.orders,
            totalPrice: event.totalPrice);
      } catch (e) {
        print(e);
        yield CheckoutError(e);
      }
    }
    if(event is PayLater){
      yield CheckoutLoading();
      Sales sales;
      ListOrder listOrder = new ListOrder([]);

      sales = new Sales("4069798d529343d59da680b1336d7dd6","1f3e2a54bb0848c6bbbc8e8d7b4f2cbe",event.totalPrice,0,"",false);
      listOrder.listOrder = event.listSalesLineItem;
      final response = await _checkoutRepository.createOrder(sales, listOrder);
      final bool success = response['success'];
      if(success){
        yield CheckoutSuccess();
      } else{
        yield CheckoutError(response['message']);
        print(response['message']);
      }
    }
  }
}
