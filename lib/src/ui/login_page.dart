import 'package:apos/src/bloc/authentication/authenticationBloc.dart';
import 'package:apos/src/bloc/authentication/authenticationEvent.dart';
import 'package:apos/src/bloc/authentication/authenticationState.dart';
import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/bloc/login/loginBloc.dart';
import 'package:apos/src/bloc/login/loginEvent.dart';
import 'package:apos/src/bloc/login/loginState.dart';
import 'package:apos/src/resources/authenticationRepository.dart';
import 'package:apos/src/ui/transaksi_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apos/src/ui/register_page.dart';
import 'package:apos/src/ui/lupa_password_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc,LoginState>(
      builder: (context, state){
        if(state is LoginInProgress){
          return LoadingIndicator();
        }
        if(state is LoginSuccess){
          return BlocProvider(
            create: (context) => MenuBloc(),
            child: TransaksiMenu()
          );
        }
        return _LoginForm();
      },
    );
  }
}


class _LoginForm extends StatefulWidget {
  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
          email: _emailController.text, password: _passwordController.text));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color.fromRGBO(54, 58, 155, 1),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: <
                        Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.height / 17),
                    child: Center(
                      child: Image(
                          height: MediaQuery.of(context).size.height / 3,
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
                                            color:
                                                Color.fromRGBO(179, 179, 183, 1),
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
                                            color:
                                                Color.fromRGBO(179, 179, 183, 1),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          60, 16, 60, 16),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100.0))),
                                      child: Text("Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'CircularStd-Bold')),
                                      onPressed: state is! LoginInProgress ? _onLoginButtonPressed : null,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterPage()),
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
                                              builder: (context) =>
                                                  LupaPasswordPage()),
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
            ),
          );
        },
      ),
    );
  }
}