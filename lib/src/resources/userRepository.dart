import 'package:apos/src/models/userModels.dart';
import 'package:apos/src/resources/userProvider.dart';

class UserRepository {
  final UserProvider _userProvider = new UserProvider();

  Future registerUser(User user) => _userProvider.registerUser(user);

  Future<void> signIn(String email, String password){
    return _userProvider.loginUser(
      email: email, password: password
    );
  }
}