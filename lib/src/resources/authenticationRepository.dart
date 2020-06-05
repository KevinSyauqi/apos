import '../models/models.dart';

abstract class AuthenticationRepository {
  Future<User> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class FakeAuthenticationRepository extends AuthenticationRepository {
  @override
  Future<User> getCurrentUser() async {
    return null; // return null for now
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // simulate a network delay

    print("Masuk sini");
    if (email.toLowerCase() != 'admin@apos.com' || password != 'admin') {
      throw Exception('Wrong username or password');
    }
    return User("Test User", email, "Test", password, "086732537232", "");
  }

  @override
  Future<void> signOut() {
    return null;
  }
}