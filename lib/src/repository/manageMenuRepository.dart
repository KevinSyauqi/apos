import 'package:apos/src/models/models.dart';
import 'package:apos/src/provider/manageMenuProvider.dart';

class ManageMenuRepository{
  final ManageMenuProvider menuProvider = new ManageMenuProvider();

  Future<List<Menu>> fetchAllMenu() async{
    return await menuProvider.fetchAllMenu();
  }

  Future addMenu(Menu menu) => menuProvider.addMenu(menu);

  Future updateMenu(Menu menu) => menuProvider.updateMenu(menu);

//  Future<Menu> fetchMenu() async{
//    return await menuProvider.fetchMenu();
//  }
}