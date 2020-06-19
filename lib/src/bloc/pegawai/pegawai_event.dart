
abstract class PegawaiEvent {
  const PegawaiEvent();
}

class FetchingAllPegawaiStore extends PegawaiEvent {
  final String username;
  final String password;

  FetchingAllPegawaiStore({this.username, this.password});


}
