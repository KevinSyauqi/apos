import 'package:apos/src/models/userModels.dart';
import 'package:apos/src/resources/userProvider.dart';

class Repository {
  final userProvider = UserProvider();

//  Future<List<User>> fetchAllUser() => userProvider.fetchUserList();

  Future registerUser(String name_user, String email_user, String username,
      String password_user, String phone_user) => userProvider.registerUser(
    name_user, email_user, username, password_user, phone_user);
}