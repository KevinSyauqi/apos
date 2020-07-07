import 'package:apos/src/models/pegawaiModels.dart';
import 'package:apos/src/models/userModels.dart';
import 'package:apos/src/resources/pegawaiProvider.dart';

class PegawaiRepository{
  final PegawaiProvider pegawaiProvider = new PegawaiProvider();

  Future<List<Pegawai>> fetchAllPegawaiOutlet(String outlet) async{
    return await pegawaiProvider.fetchAllPegawaiOutlet(outlet);
  }

  Future addPegawai(Pegawai pegawai, User user) async
  => await pegawaiProvider.addPegawai(pegawai, user);

//  Future<Menu> fetchMenu() async{
//    return await menuProvider.fetchMenu();
//  }
}