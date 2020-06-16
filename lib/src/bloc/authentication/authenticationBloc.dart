import 'package:apos/src/bloc/authentication/authenticationEvent.dart';
import 'package:apos/src/bloc/authentication/authenticationState.dart';
import 'package:apos/src/resources/authenticationRepository.dart';
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
      yield AuthenticationSuccess();
    }
  }
}
