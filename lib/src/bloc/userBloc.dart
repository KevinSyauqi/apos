import 'package:apos/src/models/userModels.dart';
import 'package:apos/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _repository = Repository();
  final _userFetcher = PublishSubject<List<User>>();

  final _name_user = BehaviorSubject<String>();
  final _email_user = BehaviorSubject<String>();
  final _username = BehaviorSubject<String>();
  final _password_user = BehaviorSubject<String>();
  final _phone_user = BehaviorSubject<String>();
//  final _photo_user = BehaviorSubject<String>();

  Stream<List<User>> get AllUser => _userFetcher.stream;

  Function(String) get name_user => _name_user.sink.add;
  Function(String) get email_user => _email_user.sink.add;
  Function(String) get username_user => _username.sink.add;
  Function(String) get password_user => _password_user.sink.add;
  Function(String) get phone_user => _phone_user.sink.add;

//  fetchAllUser() async{
//    List<User> users = await _repository.fetchAllUser();
//    _userFetcher.sink.add(users);
//  }

  registerUser() async {
    await _repository.registerUser(_name_user.value, _email_user.value,
      _username.value, _password_user.value, _phone_user.value);
    
  }

  dispose(){
    _userFetcher.close();
    _name_user.close();
    _email_user.close();
    _username.close();
    _password_user.close();
    _phone_user.close();
  }
}

final bloc = UserBloc();