import 'package:apos/src/models/outletModels.dart';
import 'package:apos/src/resources/outletProvider.dart';

class OutletRepository{
  final OutletProvider outletProvider = new OutletProvider();

  Future<List<Outlet>> fetchAllOutletStore(String store) async{
    return await outletProvider.fetchAllOutletStore(store);
  }

  Future addOutlet(Outlet outlet) async{
    return await outletProvider.addOutlet(outlet);
  }

//  Future<Menu> fetchMenu() async{
//    return await menuProvider.fetchMenu();
//  }
}