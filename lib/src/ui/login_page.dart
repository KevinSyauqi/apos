import 'package:apos/src/bloc/authentication/authenticationBloc.dart';
import 'package:apos/src/bloc/authentication/authenticationEvent.dart';
import 'package:apos/src/bloc/authentication/authenticationState.dart';
import 'package:apos/src/bloc/loginBloc.dart';
import 'package:apos/src/bloc/loginEvent.dart';
import 'package:apos/src/bloc/loginState.dart';
import 'package:apos/src/resources/authenticationRepository.dart';
import 'package:apos/src/ui/transaksi_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apos/src/ui/register_page.dart';
import 'package:apos/src/ui/lupa_password_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(54, 58, 155, 1),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          final authBloc = BlocProvider.of<AuthenticationBloc>(context);
          if (state is AuthenticationNotAuthenticated) {
            return _AuthForm(); // Show authentication form
          }
          if (state is AuthenticationFailure) {
            // Show error message
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(state.message),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Retry'),
                      onPressed: () {
                        authBloc.add(AppLoaded());
                      },
                    )
                  ],
                ));
          }
          // Show Splash Screen
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        },
      ),
    );
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authRepository =
    RepositoryProvider.of<AuthenticationRepository>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authBloc, authRepository),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
      if (_key.currentState.validate()) {
        _loginBloc.add(LoginInWithEmailButtonPressed(
            email: _emailController.text, password: _passwordController.text));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        _showError(state.error);
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is LoginLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height/17),
                  child: Center(
                    child: Image(height: MediaQuery.of(context).size.height/3,
                        image: AssetImage('images/splash-1.png')),
                  ),
                ),
                Align(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60.0),
                          topRight: Radius.circular(60.0),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(252, 195, 108, 1),
                              Color.fromRGBO(253, 166, 125, 1),
                            ])),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height / 30, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text("Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36.0,
                                  fontFamily: 'CircularStd-Bold')),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Form(
                              key: _key,
                              autovalidate: _autoValidate,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.mail,
                                        color: Color.fromRGBO(179, 179, 183, 1),
                                      ),
                                      hintText: "Masukkan Email Pengguna",
                                      hintStyle: TextStyle(
                                          color: Color.fromRGBO(179, 179, 183, 1),
                                          fontSize: 13.0,
                                          fontFamily: 'CircularStd-Book'),
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 16.0),
                                      filled: true,
                                      isDense: true,
                                    ),
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    autocorrect: false,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Email is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Color.fromRGBO(179, 179, 183, 1),
                                      ),
                                      hintText: "Masukkan Password Pengguna",
                                      hintStyle: TextStyle(
                                          color: Color.fromRGBO(179, 179, 183, 1),
                                          fontSize: 13.0,
                                          fontFamily: 'CircularStd-Book'),
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 16.0),
                                      filled: true,
                                      isDense: true,
                                    ),
                                    obscureText: true,
                                    controller: _passwordController,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Password is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    textColor: Colors.white,
                                    padding:
                                    const EdgeInsets.fromLTRB(60, 16, 60, 16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(100.0))),
                                    child: Text("Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'CircularStd-Bold')),
                                    onPressed: state is LoginLoading
                                        ? () {}
                                        : _onLoginButtonPressed,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RegisterPage()),
                                        );
                                      },
                                      child: Text("Belum Daftar?",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'CircularStd-Book'))),
                                  Text(" | ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'CircularStd-Book')),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LupaPasswordPage()),
                                      );
                                    },
                                    child: Text("Lupa Password",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'CircularStd-Book')),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      );
    }));
  }

  void _showError(String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }
}
