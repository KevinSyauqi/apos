import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/resources/menuRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepository menuRepository = MenuRepository();

  @override
  MenuState get initialState => MenuInitialized();

  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    List<Menu> menus;
    try{
      if (event is FetchingAllMenu) {
        yield MenuLoading();
        menus = await menuRepository
            .fetchAllMenuOutlet("4069798d529343d59da680b1336d7dd6");
        if (menus.length == 0) {
          yield MenuEmpty();
        } else {
          yield MenuLoaded(menus: menus);
        }
      }
    }catch(_){
      yield MenuError();
    }

  }
}
