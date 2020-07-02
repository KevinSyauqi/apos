import 'package:apos/src/models/pegawaiModels.dart';
import 'package:apos/src/resources/pegawaiProvider.dart';

class PegawaiRepository{
  final PegawaiProvider pegawaiProvider = new PegawaiProvider();

  Future<List<Pegawai>> fetchAllPegawaiOutlet(String outlet) async{
    return await pegawaiProvider.fetchAllPegawaiOutlet(outlet);
  }

  Future addPegawai(Pegawai pegawai, String id_outlet, String username, String email_user, String password_user, String phone_user, String role, String name_user)
  => pegawaiProvider.addPegawai(pegawai, id_outlet, username, email_user, password_user, phone_user, role, name_user);

//  Future<Menu> fetchMenu() async{
//    return await menuProvider.fetchMenu();
//  }
}