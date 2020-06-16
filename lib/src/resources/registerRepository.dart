import 'package:apos/src/models/userModels.dart';
import 'package:apos/src/resources/userProvider.dart';

class RegisterRepository {
  final UserProvider _userProvider = new UserProvider();

  Future registerUser(User user) => _userProvider.registerUser(user);
}