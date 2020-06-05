import 'package:apos/src/bloc/authentication/authenticationBloc.dart';
import 'package:apos/src/bloc/loginEvent.dart';
import 'package:apos/src/bloc/loginState.dart';
import 'package:apos/src/resources/authenticationRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/authenticationEvent.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _authenticationRepository;

  LoginBloc(AuthenticationBloc authenticationBloc,
      AuthenticationRepository authenticationRepository)
      : assert(authenticationBloc != null),
        assert(authenticationRepository != null),
        _authenticationBloc = authenticationBloc,
        _authenticationRepository = authenticationRepository;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithEmailButtonPressed) {
      yield* _mapLoginWithEmailToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(
      LoginInWithEmailButtonPressed event) async* {
    yield LoginLoading();
    try {
      final user = await _authenticationRepository.signInWithEmailAndPassword(
          event.email, event.password);
      if(user != null){
        // Push new authentication event
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    } on Exception catch(e){
      yield LoginFailure(error: "An unknown error occured");
    } catch (error){
      yield LoginFailure(error: error ?? 'An unknown error occured');
    }
  }
}
