import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/manageMenuRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final ManageMenuRepository _menuRepository = ManageMenuRepository();

  @override
  MenuState get initialState => MenuInitialized();

  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    List<Menu> menus;
    try {
      if (event is FetchingAllMenu) {
        yield MenuLoading();
        menus = await _menuRepository
            .fetchAllMenu();
        if (menus.length == 0) {
          yield MenuEmpty();
        } else {
          List<Menu> foods = List();
          List<Menu> drinks = List();

          menus.forEach((menu) {
            if (menu.category == "food") foods.add(menu);
            else drinks.add(menu);
          });

          yield MenuLoaded(foods: foods, drinks: drinks);
        }
      }
      if (event is AddMenuButtonPressed) {
        yield MenuAddInitialized();
      }
      if (event is AddMenuButtonFormPressed) {
        yield MenuAddLoading();
        Menu menu;
        String category;
        if(event.category == "Makanan") category = "food";
        else category = "drink";


        final response = await _menuRepository.addMenu(menu, "S20001");
        final bool success = response['success'];
        if(success){
          yield MenuAddSuccess();
        } else{
          yield MenuAddFailed(message: response['message']);
        }
    }

    }catch(e){
      print(e);
      yield MenuError();
    }

  }
}
