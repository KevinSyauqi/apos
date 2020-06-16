import 'package:apos/src/models/pegawaiModels.dart';
import 'package:apos/src/resources/pegawaiProvider.dart';

class PegawaiRepository{
  final PegawaiProvider pegawaiProvider = new PegawaiProvider();

  Future<List<Pegawai>> fetchAllPegawaiOutlet(String store) async{
    return await pegawaiProvider.fetchAllPegawaiOutlet(store);
  }

//  Future<Menu> fetchMenu() async{
//    return await menuProvider.fetchMenu();
//  }
}