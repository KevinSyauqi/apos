import 'dart:async';
import 'package:apos/src/models/salesLineItemModels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apos/src/bloc/bloc.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  @override
  CheckoutState get initialState => CheckoutInitialized();

  @override
  Stream<CheckoutState> mapEventToState(
    CheckoutEvent event,
  ) async* {
    if(event is LoadCart){
      yield CheckoutLoading();
      try{
        yield CheckoutLoaded(listSalesLineItem: [],menus: [], totalPrice: 0);
      }catch(e){
        print(e);
        yield CheckoutError();
      }
    }
    if(event is AddCheckout){
      final currentState = state;
      if(currentState is CheckoutLoaded){
        try{
          yield CheckoutLoaded(
            menus: List.from(currentState.menus)..add(event.menu), totalPrice: currentState.totalPrice + event.menu.price
          );
        }catch(e){
          print(e);
          yield CheckoutError();
        }
      }
    }
    if(event is RemoveFromCheckout){
      final currentState = state;
      if(currentState is CheckoutLoaded){
        try{
          yield CheckoutLoaded(
              menus: List.from(currentState.menus)..remove(event.menu), totalPrice: currentState.totalPrice - event.menu.price
          );
        }catch(e){
          print(e);
          yield CheckoutError();
        }
      }
    }
    if(event is CheckoutPressed){
      final currentState = state;
      if(currentState is CheckoutLoaded){
        try{
          List<SalesLineItem> listOrder;
          SalesLineItem order;

          listOrder = currentState.listSalesLineItem;

          currentState.menus.forEach((menu) {
            if(listOrder.contains(menu.id_outlet_menu)){
              listOrder.elementAt(listOrder.indexWhere((order) => order.id_outlet_menu == menu.id_outlet_menu)).qty++;
              listOrder.elementAt(listOrder.indexWhere((order) => order.id_outlet_menu == menu.id_outlet_menu)).subtotal_price + menu.price;
            }else{
              order = new SalesLineItem(menu.id_outlet_menu, 1, menu.price, 0);
              currentState.listSalesLineItem.add(order);
            }
          });
          yield CheckoutLoaded(listSalesLineItem: listOrder);
        }catch(e){
          print(e);
          yield CheckoutError();
        }
      }
    }
  }
}
