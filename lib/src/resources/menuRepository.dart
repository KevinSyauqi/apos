import 'package:apos/src/models/models.dart';
import 'package:apos/src/resources/menuProvider.dart';

class MenuRepository{
  final MenuProvider menuProvider = new MenuProvider();

  Future<List<Menu>> fetchAllMenuOutlet(String outlet) async{
    return await menuProvider.fetchAllMenuOutlet(outlet);
  }

  Future addMenu(Menu menu, String store) => menuProvider.addMenu(menu, store);

//  Future<Menu> fetchMenu() async{
//    return await menuProvider.fetchMenu();
//  }
}