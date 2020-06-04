import 'package:apos/src/resources/userProvider.dart';

class UserRepository {
  final userProvider = UserProvider();

  Future registerUser(String name_user, String email_user, String username,
      String password_user, String phone_user) => userProvider.registerUser(
    name_user, email_user, username, password_user, phone_user);
}