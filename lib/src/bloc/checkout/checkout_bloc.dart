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
  Stream<CheckoutState> mapEventToState(CheckoutEvent event,) async* {
    if (event is CheckoutDispose) {
      yield CheckoutInitialized();
    }
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
              menus: List.from(currentState.menus)
                ..add(event.menu),
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
              menus: List.from(currentState.menus)
                ..remove(event.menu),
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
          if (listOrder.any((item) =>
          item.id_outlet_menu == menu.id_outlet_menu)) {
            final index = listOrder.indexWhere((item) =>
            item.id_outlet_menu == menu.id_outlet_menu);
            listOrder[index].qty++;
            listOrder[index].subtotal_price =
                listOrder[index].subtotal_price + menu.price;
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
    if (event is PayLater) {
      yield CheckoutInProgress();
      Sales sales;
      ListOrder listOrder = new ListOrder([]);

      sales =
      new Sales("OS2000101", "S20001001", event.totalPrice, 0, "", false);
      listOrder.listOrder = event.listSalesLineItem;
      final response = await _checkoutRepository.createOrder(sales, listOrder);
      final bool success = response['success'];
      if (success) {
        yield CheckoutSuccess();
      } else {
        yield CheckoutError(response['message']);
        print(response['message']);
      }
    }
    if (event is PayNow) {
      if(event.totalPrice != null){
        yield CheckoutLoaded(menus: event.listMenu,
            listSalesLineItem: event.listSalesLineItem,
            totalPrice: event.totalPrice);
      }else{
        yield CheckoutError("Belum ada keranjang");
        print("Belum ada keranjang");
      }
    }
  }
}
