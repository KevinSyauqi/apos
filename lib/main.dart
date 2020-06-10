import 'package:apos/src/bloc/authentication/authenticationBloc.dart';
import 'package:apos/src/bloc/authentication/authenticationEvent.dart';
import 'package:apos/src/bloc/authentication/authenticationState.dart';
import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/resources/authenticationRepository.dart';
import 'package:apos/src/resources/repository.dart';
import 'package:apos/src/ui/login_page.dart';
import 'package:apos/src/ui/splash_page.dart';
import 'package:apos/src/ui/transaksi_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    print(event.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final authenticationRepository = AuthenticationRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context){
        return AuthenticationBloc(authenticationRepository: authenticationRepository)..add(AuthenticationStarted());
      },
      child: Apos(authenticationRepository: authenticationRepository),
    )
  );
}


class Apos extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  Apos({Key key, @required this.authenticationRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state){
          if(state is AuthenticationSuccess){
            final menuRepository = MenuRepository();
            return BlocProvider<MenuBloc>(
                create: (context){
                  return MenuBloc(menuRepository: MenuRepository())..add(FetchingAllMenu());
                },
              child: TransaksiMenu(menuRepository: menuRepository),
            );
          }
          if(state is AuthenticationFailure){
            return LoginPage(authenticationRepository: authenticationRepository);
          }
          if(state is AuthenticationInProgress){
            return LoadingIndicator();
          }
          return SplashPage();
        },
      )
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: CircularProgressIndicator(),
  );
}