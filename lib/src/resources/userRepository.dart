import 'package:apos/src/models/userModels.dart';
import 'package:apos/src/resources/userProvider.dart';

class UserRepository {
  final userProvider = UserProvider();

//  Future<List<User>> fetchAllUser() => userProvider.fetchUserList();

  Future registerUser(User user) => userProvider.registerUser(user);

  Future<User> getUser(){
    return userProvider.getUser();
  }
}