import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/models/photoModels.dart';
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
        menus = await _menuRepository.fetchAllMenu();
        if (menus.length == 0) {
          yield MenuEmpty();
        } else {
          List<Menu> foods = List();
          List<Menu> drinks = List();
          List<Menu> noactiveMenus = List();

          menus.forEach((menu) {
            if(menu.is_active == true){
              if (menu.category == "food")
                foods.add(menu);
              else
                drinks.add(menu);
            } else
              noactiveMenus.add(menu);
          });

          yield MenuLoaded(foods: foods, drinks: drinks, noActiveMenus: noactiveMenus);
        }
      }
      if (event is AddMenuButtonPressed) {
        yield MenuAddInitialized();
      }
      if (event is AddMenuButtonFormPressed) {
        yield MenuAddLoading();
        Menu menu = new Menu(event.name_menu, event.category, int.parse(event.cost), int.parse(event.price));
        Photo photo = new Photo(event.base64_photo);
        String category;
        print(menu);
        if (event.category == "Makanan")
          menu.category = "food";
        else
          menu.category = "drink";
        
        final response = await _menuRepository.addMenu(menu, photo);
        final bool success = response['success'];
        if (success) {
          yield MenuAddSuccess();
        } else {
          yield MenuAddFailed(message: response['message']);
        }
      }
      if (event is UpdateMenuButton) {
        yield MenuUpdateLoading();
        Menu menu;
        yield MenuUpdateLoaded(menu : menu);
      }
      if (event is UpdateMenuButtonFormPressed) {
        yield MenuUpdateLoading();
        Menu menu = new Menu(event.name_menu, event.category, int.parse(event.cost), int.parse(event.price));
        Photo photo = new Photo(event.base64_photo);
        menu.id_menu = event.id_menu;
        print(menu);
        if (event.category == "Makanan")
          menu.category = "food";
        else
          menu.category = "drink";
        
        final response = await _menuRepository.updateMenu(menu, photo);
        final bool success = response['success'];
        if (success) {
          yield MenuUpdateSuccess();
        } else {
          yield MenuUpdateFailed(message: response['message']);
        }
      }
      if(event is FetchMenu){
        if(event.menu != null){
          yield MenuUpdateLoaded(menu: event.menu);
        }else yield MenuUpdateError();
      }
      if(event is DeactiveMenu){
        final response = await _menuRepository.deactiveMenu(event.id_menu);
        if(response["success"] == true){
          yield DeactiveMenuSuccess();
        }else yield MenuError();
      }
      if(event is ActiveMenu){
        final response = await _menuRepository.activeMenu(event.id_menu);
        if(response["success"] == true){
          yield ActiveMenuSuccess();
        }else yield MenuError();
      }
    } catch (e) {
      print(e);
      yield MenuError();
    }
  }
}
