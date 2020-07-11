import 'package:apos/src/models/pegawaiModels.dart';
import 'package:apos/src/models/userModels.dart';
import 'package:apos/src/resources/pegawaiProvider.dart';

class PegawaiRepository{
  final PegawaiProvider pegawaiProvider = new PegawaiProvider();

  Future<List<Pegawai>> fetchAllPegawaiOutlet(String outlet) async{
    return await pegawaiProvider.fetchAllPegawaiOutlet(outlet);
  }

  Future addPegawai(Pegawai pegawai, User user, String id_store) async
  => await pegawaiProvider.addPegawai(pegawai, user, id_store);

//  Future<Menu> fetchMenu() async{
//    return await menuProvider.fetchMenu();
//  }
}