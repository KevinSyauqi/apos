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
    BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: Apos(),
    )
  );
}

class Apos extends StatefulWidget {
  @override
  _AposState createState() => _AposState();
}

class _AposState extends State<Apos> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
        _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
        _authenticationBloc..add(AuthenticationStarted());
        super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    _authenticationBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state){
            if(state is AuthenticationSuccess){
              return BlocProvider(
                create: (context) => MenuBloc(),
                child: TransaksiMenu(),
              );
            }
            if(state is AuthenticationEmpty){
              return BlocProvider(
                create: (context) => LoginBloc(),
                child: LoginPage(),
              );
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(54, 58, 155, 1),
      body: Container(
        padding: EdgeInsets.all(60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('images/splash.png')),
            SizedBox(height: 20),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}