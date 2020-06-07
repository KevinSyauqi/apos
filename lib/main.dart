import 'package:apos/src/bloc/authentication/authenticationBloc.dart';
import 'package:apos/src/bloc/authentication/authenticationEvent.dart';
import 'package:apos/src/resources/authenticationRepository.dart';
import 'package:apos/src/ui/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() =>
    runApp(
        RepositoryProvider<AuthenticationRepository>(
          create: (context) {
            return FakeAuthenticationRepository();
          },
          child: BlocProvider<AuthenticationBloc>(
            create: (context) {
              final authRepository = RepositoryProvider.of<
                  AuthenticationRepository>(context);
              return AuthenticationBloc(authRepository)..add(AppLoaded());
            },
            child: Apos(),
          ),
        )
    );

class Apos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage()
    );
  }
}