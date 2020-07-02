class PegawaiEvent {}

class FetchingAllPegawai extends PegawaiEvent {}

class AddPegawaiButtonPressed extends PegawaiEvent {}

class AddPegawaiButtonFormPressed extends PegawaiEvent {
  final String id_outlet;
  final String name_user;
  final String role;
  final String status;
  final String username;
  final String password_user;
  final String email_user;
  final String phone_user;

  AddPegawaiButtonFormPressed({this.id_outlet, this.name_user, this.role,
    this.status, this.username, this.password_user, this.email_user, this.phone_user});


}
