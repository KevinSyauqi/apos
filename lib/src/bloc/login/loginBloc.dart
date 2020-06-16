import 'package:apos/src/bloc/authentication/authenticationBloc.dart';
import 'package:apos/src/bloc/authentication/authenticationEvent.dart';
import 'package:apos/src/bloc/login/loginEvent.dart';
import 'package:apos/src/bloc/login/loginState.dart';
import 'package:apos/src/resources/repository.dart';
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
      await Future.delayed(Duration(seconds: 2)); // Nanti ganti sama login di repository


      yield LoginSuccess();

      authenticationBloc.add(AuthenticationLoggedIn(token: "Token"));
      yield LoginInitial();
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
