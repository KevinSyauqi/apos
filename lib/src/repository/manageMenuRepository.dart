import 'package:apos/src/models/models.dart';
import 'package:apos/src/provider/manageMenuProvider.dart';

class ManageMenuRepository{
  final ManageMenuProvider menuProvider = new ManageMenuProvider();

  Future<List<Menu>> fetchAllMenu() async{
    return await menuProvider.fetchAllMenu();
  }

  Future addMenu(Menu menu) async => await menuProvider.addMenu(menu);

  Future updateMenu(Menu menu) async => await menuProvider.updateMenu(menu);

  Future deactiveMenu(String id_menu) async => await menuProvider.deactiveMenu(id_menu);

  Future activeMenu(String id_menu) async => await menuProvider.activeMenu(id_menu);

  Future fetchMenu(String id_menu) async{
    return await menuProvider.fetchMenu(id_menu);
  }
}