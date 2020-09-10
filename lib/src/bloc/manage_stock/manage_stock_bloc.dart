import 'dart:async';
import 'package:apos/src/bloc/manage_stock/manage_stock_event.dart';
import 'package:apos/src/bloc/manage_stock/manage_stock_state.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/manageOrderRepository.dart';
import 'package:apos/src/repository/manageStockRepository.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class ManageStockBloc extends Bloc<ManageStockEvent, ManageStockState> {
  final ManageStockRepository _manageStockRepository = ManageStockRepository();

  @override
  ManageStockState get initialState => ManageStockInitialized();

  @override
  Stream<ManageStockState> mapEventToState(
    ManageStockEvent event,
  ) async* {
    try {
      if (event is FetchStockMenus) {
        yield ManageStockLoading();
        List<Menu> menus;
        menus = await _manageStockRepository
            .fetchAllMenu();
        if (menus.length == 0) {
          yield ManageStockEmpty();
        } else {
          List<Menu> foods = List<Menu>();
          List<Menu> drinks = List<Menu>();

          menus.forEach((menu) {
            if (menu.category == "food") foods.add(menu);
            else drinks.add(menu);
          });

          yield ManageStockLoaded(foods: foods, drinks: drinks,
              foodMenuCounter: new List(foods.length),
              drinkMenuCounter: new List(drinks.length));
        }
      }
      if(event is StockMenuIncrement){
          yield StockCount();
      }

    }catch(e){
      print(e);
      yield StockError();
    }
  }
}
