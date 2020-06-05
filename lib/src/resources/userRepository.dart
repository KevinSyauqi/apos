import 'package:apos/src/models/userModels.dart';
import 'package:apos/src/resources/userProvider.dart';

class UserRepository {
  final userProvider = UserProvider();

  Future registerUser(User user) => userProvider.registerUser(user);
}