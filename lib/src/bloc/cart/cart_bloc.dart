import 'dart:async';
import 'package:apos/src/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apos/src/bloc/bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  @override
  CartState get initialState => CartInitialized();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is CheckoutDispose) {
      yield CartInitialized();
    }
    if (event is LoadCart) {
      yield CartLoading();
      try {
        yield CartLoaded(cart: [], menus: [], totalPrice: 0);
      } catch (e) {
        print(e);
        yield CartError(e);
      }
    }
    if (event is AddToCart) {
      final currentState = state;
      if (currentState is CartLoaded) {
        try {
          yield CartLoaded(
              menus: List.from(currentState.menus)
                ..add(event.menu),
              totalPrice: currentState.totalPrice + event.menu.price);
        } catch (e) {
          print(e);
          yield CartError(e);
        }
      }
    }
    if (event is RemoveFromCart) {
      final currentState = state;
      if (currentState is CartLoaded) {
        try {
          print(currentState.menus.toString());
          yield CartLoaded(
              menus: List.from(currentState.menus)
                ..remove(event.menu),
              totalPrice: currentState.totalPrice - event.menu.price);

        } catch (e) {
          print(e);
          yield CartError(e);
        }
      }
    }
    if (event is CheckoutCart) {
      try {
        List<OrderItem> listOrder;
        OrderItem order;
        listOrder = [];
        yield CartLoading();
        event.orderMenus.forEach((menu) {
          if (listOrder.any((item) =>
          item.id_menu == menu.id_menu)) {
            final index = listOrder.indexWhere((item) =>
            item.id_menu == menu.id_menu);
            listOrder[index].quantity++;
            listOrder[index].name_menu = menu.name_menu;
            listOrder[index].subtotal_price =
                listOrder[index].subtotal_price + menu.price;
            listOrder[index].subtotal_cost =
                listOrder[index].subtotal_cost + menu.cost;
            print(listOrder[index].toJson().toString());
          } else {
            order = new OrderItem(menu.id_menu, menu.name_menu, 1, menu.price, menu.cost);
            print(order.toJson().toString());
            listOrder.add(order);
          }
        });
        yield CartLoaded(
            cart: listOrder,
            menus: event.orderMenus,
            totalPrice: event.totalPrice);
      } catch (e) {
        print(e);
        yield CartError(e);
      }
    }
  }
}
