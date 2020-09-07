import 'dart:async';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/manageOrderRepository.dart';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class ManageOrderBloc extends Bloc<ManageOrderEvent, ManageOrderState> {
  final ManageOrderRepository _manageOrderRepository = ManageOrderRepository();

  @override
  ManageOrderState get initialState => ManageOrderInitialized();

  @override
  Stream<ManageOrderState> mapEventToState(
    ManageOrderEvent event,
  ) async* {
    try {
      if (event is FetchMenus) {
        yield ManageOrderLoading();
        List<Menu> menus;
        menus = await _manageOrderRepository
            .fetchAllMenu();
        if (menus.length == 0) {
          yield ManageOrderEmpty();
        } else {
          List<Menu> foods = List<Menu>();
          List<Menu> drinks = List<Menu>();

          menus.forEach((menu) {
            if (menu.category == "food") foods.add(menu);
            else drinks.add(menu);
          });

          yield ManageOrderLoaded(foods: foods, drinks: drinks,
              foodMenuCounter: new List(foods.length),
              drinkMenuCounter: new List(drinks.length));
        }
      }
      if(event is OrderMenuIncrement){
          yield OrderCount();
      }

    }catch(e){
      print(e);
      yield OrderError();
    }
  }
}
