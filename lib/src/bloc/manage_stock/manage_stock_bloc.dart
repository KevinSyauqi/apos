import 'dart:async';
import 'package:apos/src/bloc/manage_stock/manage_stock_event.dart';
import 'package:apos/src/bloc/manage_stock/manage_stock_state.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/manageStockRepository.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class ManageStockBloc extends Bloc<ManageStockEvent, ManageStockState> {
  final ManageStockRepository _manageStockRepository = ManageStockRepository();

  @override
  ManageStockState get initialState => ManageStockInitialized();

  @override
  Stream<ManageStockState> mapEventToState(ManageStockEvent event,) async* {
    List<Menu> menus;
    try {
      if (event is FetchingAllStock) {
        print(menus);
        yield ManageStockLoading();
        menus = await _manageStockRepository
            .fetchAllStock();
        if (menus.length == 0) {
          yield ManageStockEmpty();
        } else {
          List<Menu> foods = List();
          List<Menu> drinks = List();

          menus.forEach((menu) {
            if (menu.category == "food") foods.add(menu);
            else drinks.add(menu);
          });

          yield ManageStockLoaded(foods: foods, drinks: drinks);
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
