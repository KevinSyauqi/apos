import 'package:apos/src/bloc/authentication/authentication_bloc.dart';
import 'package:apos/src/bloc/authentication/authentication_event.dart';
import 'package:apos/src/bloc/authentication/authentication_state.dart';
import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/ui/home_page.dart';
import 'package:apos/src/ui/login/login_page.dart';
import 'package:apos/src/ui/splash_page.dart';
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
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc()..add(AuthenticationStarted()),
      child: Apos(),
    )
  );
}

class Apos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state){
            if(state is AuthenticationSuccess){
              return HomePage();
            }
            if(state is AuthenticationEmpty){
              return LoginPage();
            }
            if(state is AuthenticationInProgress){
              return LoadingIndicator();
            }
            if(state is AuthenticationFailure){
              return LoginPage();
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