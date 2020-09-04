import 'package:apos/src/bloc/authentication/authentication_event.dart';
import 'package:apos/src/bloc/authentication/authentication_state.dart';
import 'package:apos/src/repository/authenticationRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository = AuthenticationRepository();

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      await Future.delayed(Duration(seconds: 2));
      yield AuthenticationInProgress();
      String sharedPreference;
      // Nanti disini kasih cek sharedpreference
      // Boolean dibawah diganti kondisi kalau ada shared preference
      await Future.delayed(Duration(seconds: 2));
      if(sharedPreference == null ){
        yield AuthenticationEmpty();
      }
    }
    if(event is AuthenticationLoggedIn){
      // Shared Preference Disini nanti tambahin
      yield AuthenticationSuccess();
    }
    if(event is AuthenticationFailed){
      yield AuthenticationFailure();
    }
  }
}
