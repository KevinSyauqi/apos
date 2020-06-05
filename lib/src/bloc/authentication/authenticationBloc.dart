import 'package:apos/src/bloc/authentication/authenticationEvent.dart';
import 'package:apos/src/bloc/authentication/authenticationState.dart';
import 'package:apos/src/resources/authenticationRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(AuthenticationRepository authenticationRepository)
      :assert(authenticationRepository != null),
  _authenticationRepository = authenticationRepository;

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if(event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if(event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if(event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationLoading(); // Display Splashscreen
    try {
      await Future.delayed(Duration(milliseconds: 500)); // Simulasi loading
      final currentUser = await _authenticationRepository.getCurrentUser();

      if(currentUser != null){
        yield AuthenticationAuthenticated(user: currentUser);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e){
      yield AuthenticationFailure(message: e.mesage ?? 'An unknown error occured');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(UserLoggedIn event) async* {
    yield AuthenticationAuthenticated(user: event.user);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(UserLoggedOut event) async* {
    await _authenticationRepository.signOut();
    yield AuthenticationNotAuthenticated();
  }

}