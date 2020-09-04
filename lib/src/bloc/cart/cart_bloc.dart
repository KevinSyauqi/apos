import 'dart:async';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/checkoutReporitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apos/src/bloc/bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CheckoutRepository _checkoutRepository = new CheckoutRepository();

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
        event.orders.forEach((menu) {
          if (listOrder.any((item) =>
          item.id_menu == menu.id_menu)) {
            final index = listOrder.indexWhere((item) =>
            item.id_menu == menu.id_menu);
            listOrder[index].quantity++;
            listOrder[index].name_menu = menu.name_menu;
            listOrder[index].subtotal_price =
                listOrder[index].subtotal_price + menu.price;
            print(listOrder[index].toJson().toString());
          } else {
            order = new OrderItem(menu.name_menu, 1, menu.price);
            print(order.toJson().toString());
            listOrder.add(order);
          }
        });
        yield CartLoaded(
            cart: listOrder,
            menus: event.orders,
            totalPrice: event.totalPrice);
      } catch (e) {
        print(e);
        yield CartError(e);
      }
    }
    if (event is PayLater) {
      yield CheckoutInProgress();
      Order order;
      ListOrder listOrder = new ListOrder([]);

      order = new Order("S001U001", 2, "puput", event.totalPrice);
//      listOrder.listOrder = event.listOrderItem;
      final response = await _checkoutRepository.createOrder(order, listOrder);
      final bool success = response['success'];
      if (success) {
        yield CheckoutSuccess();
      } else {
        yield CartError(response['message']);
        print(response['message']);
      }
    }
    if (event is PayNow) {
      if(event.totalPrice != null){
        yield CartLoaded(menus: event.listMenu,
            cart: event.listOrderItem,
            totalPrice: event.totalPrice);
      }else{
        yield CartError("Belum ada keranjang");
        print("Belum ada keranjang");
      }
    }
  }
}
