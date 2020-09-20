import 'package:apos/src/bloc/authentication/authentication_bloc.dart';
import 'package:apos/src/bloc/authentication/authentication_event.dart';
import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/bloc/login/loginEvent.dart';
import 'package:apos/src/bloc/login/loginState.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository = AuthenticationRepository();
  final AuthenticationBloc authenticationBloc;


  LoginBloc({@required this.authenticationBloc});

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();
      final response = await authenticationRepository.authenticate(username: event.username, password: event.password);
      if(response['success'] != false){
        yield LoginSuccess();
        print(response.toString());
        final data = response["data"];
        final user = User.fromJson(data["user"]);
        final loginSession = data["loginSession"];
        String token = loginSession["id_session"];
        authenticationBloc.add(AuthenticationLoggedIn(token: token, user: user));
      }else{
        yield LoginFailure(error: "Username atau password salah");
        authenticationBloc.add(AuthenticationFailed());
      }
//      try {
//        final token = await authenticationRepository.authenticate(
//          email: event.email,
//          password: event.password,
//        );
//
//        authenticationBloc.add(AuthenticationLoggedIn(token: token));
//        yield LoginInitial();
//      } catch (error) {
//        yield LoginFailure(error: error.toString());
//      }
    }
  }
}
