import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/resources/menuRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepository _menuRepository = MenuRepository();

  @override
  MenuState get initialState => MenuInitialized();

  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    List<Menu> menus;
    try {
      if (event is FetchingAllMenu) {
        yield MenuLoading();
        menus = await _menuRepository
            .fetchAllMenuOutlet("OS2000101");
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

        if(event.is_stock == true){
          menu = Menu(
              event.name_menu,
              category,
              event.description,
              event.imgBase64,
              int.parse(event.cog),
              int.parse(event.price),
              event.is_stock,
              int.parse(event.stock));
        } else {
          menu = Menu(
              event.name_menu,
              category,
              event.description,
              event.imgBase64,
              int.parse(event.cog),
              int.parse(event.price),
              event.is_stock,
              0);
        }
        print(menu.photo_menu);
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
    yield MenuAddError();
    }

  }
}
