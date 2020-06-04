import 'package:apos/src/bloc/userEvent.dart';
import 'package:apos/src/bloc/userState.dart';
import 'package:apos/src/models/userModels.dart';
import 'package:apos/src/resources/userRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({@required UserRepository userRepository})
      : _userRepository = userRepository;


  User user;
  final UserRepository _userRepository;

  final BehaviorSubject<User> _user = BehaviorSubject<User>();
  final _nameUser = BehaviorSubject<String>();
  final _emailUser = BehaviorSubject<String>();
  final _usernameUser = BehaviorSubject<String>();
  final _passwordUser = BehaviorSubject<String>();
  final _phoneUser = BehaviorSubject<String>();


  Function(String) get name_user => _nameUser.sink.add;
  Function(String) get email_user => _emailUser.sink.add;
  Function(String) get username_user => _usernameUser.sink.add;
  Function(String) get password_user => _passwordUser.sink.add;
  Function(String) get phone_user => _phoneUser.sink.add;

  getUser() async {
    user = await _userRepository.getUser();
    _user.sink.add(user);
  }

  registerUser() async {
    user.name_user = _nameUser.value;
    user.email_user = _emailUser.value;
    user.username = _usernameUser.value;
    user.password_user = _passwordUser.value;
    user.phone_user = _phoneUser.value;

    await _userRepository.registerUser(user);

  }

  dispose(){
    _nameUser.close();
    _emailUser.close();
    _usernameUser.close();
    _passwordUser.close();
    _phoneUser.close();
    _user.close();
  }

  @override
  UserState get initialState {

  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) {
    // TODO: implement mapEventToState
    return null;
  }
}

final bloc = UserBloc();