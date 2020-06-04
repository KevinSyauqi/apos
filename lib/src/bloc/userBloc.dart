import 'package:apos/src/models/userModels.dart';
import 'package:apos/src/resources/userRepository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _userRepository = UserRepository();

  final _name_user = BehaviorSubject<String>();
  final _email_user = BehaviorSubject<String>();
  final _username = BehaviorSubject<String>();
  final _password_user = BehaviorSubject<String>();
  final _phone_user = BehaviorSubject<String>();
//  final _photo_user = BehaviorSubject<String>();

  Function(String) get name_user => _name_user.sink.add;
  Function(String) get email_user => _email_user.sink.add;
  Function(String) get username_user => _username.sink.add;
  Function(String) get password_user => _password_user.sink.add;
  Function(String) get phone_user => _phone_user.sink.add;

  registerUser() async {
    await _userRepository.registerUser(_name_user.value, _email_user.value,
      _username.value, _password_user.value, _phone_user.value);
    
  }

  dispose(){
    _name_user.close();
    _email_user.close();
    _username.close();
    _password_user.close();
    _phone_user.close();
  }
}

final bloc = UserBloc();