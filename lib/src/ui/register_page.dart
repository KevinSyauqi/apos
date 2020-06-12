import 'package:apos/src/bloc/userBloc.dart';
import 'package:apos/src/models/userModels.dart';
import 'package:apos/src/ui/login_page.dart';
import 'package:apos/src/ui/validasi_akun_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color.fromRGBO(54, 58, 155, 1),
        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Center(
                        child: Image(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 3,
                            image: AssetImage('images/splash-1.png')),
                      ),
                      SizedBox(height: MediaQuery
                          .of(context)
                          .size
                          .height / 20)
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ListView(
                  physics: new ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              child: Column(
                                children: <Widget>[
                                  Text("Registrasi",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 36.0,
                                          fontFamily: 'CircularStd-Bold')),
                                  SizedBox(height: 10),
                                  // Nama Pengguna
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                    child: TextField(
                                      onChanged: bloc.name_user,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Color.fromRGBO(
                                                179, 179, 183, 1),
                                          ),
                                          hintText: "Masukkan Nama Pengguna",
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  179, 179, 183, 1),
                                              fontSize: 13.0,
                                              fontFamily: 'CircularStd-Book'),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0,
                                              vertical: 16.0)),
                                    ),
                                  ),
                                  // Email Pengguna
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                    child: TextField(
                                      onChanged: bloc.email_user,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Color.fromRGBO(
                                                179, 179, 183, 1),
                                          ),
                                          hintText: "Masukkan Email Pengguna",
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  179, 179, 183, 1),
                                              fontSize: 13.0,
                                              fontFamily: 'CircularStd-Book'),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0,
                                              vertical: 16.0)),
                                    ),
                                  ),
                                  // Username Pengguna
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                    child: TextField(
                                      onChanged: bloc.username_user,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.contacts,
                                            color: Color.fromRGBO(
                                                179, 179, 183, 1),
                                          ),
                                          hintText: "Masukkan Username Pengguna",
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  179, 179, 183, 1),
                                              fontSize: 13.0,
                                              fontFamily: 'CircularStd-Book'),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0,
                                              vertical: 16.0)),
                                    ),
                                  ),
                                  // Password Pengguna
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                    child: TextField(
                                      onChanged: bloc.password_user,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Color.fromRGBO(
                                                179, 179, 183, 1),
                                          ),
                                          hintText: "Masukkan Password Pengguna",
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  179, 179, 183, 1),
                                              fontSize: 13.0,
                                              fontFamily: 'CircularStd-Book'),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0,
                                              vertical: 16.0)),
                                    ),
                                  ),
                                  // Nomor Telepon
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                    child: TextField(
                                      onChanged: bloc.phone_user,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.phone,
                                            color: Color.fromRGBO(
                                                179, 179, 183, 1),
                                          ),
                                          hintText: "Masukkan Telepon Pengguna",
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  179, 179, 183, 1),
                                              fontSize: 13.0,
                                              fontFamily: 'CircularStd-Book'),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0,
                                              vertical: 16.0)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 2,
                                    padding: EdgeInsets.only(
                                        top: 5, bottom: 15),
                                    child: RaisedButton(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 18),
                                        color: Color.fromRGBO(54, 58, 155, 1),
                                        elevation: 5,
                                        onPressed: () async {
                                          await bloc.registerUser();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ValidasiAkunPage()));
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100.0))),
                                        child: Text("Register",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ))),
                                  ),
                                  SizedBox(height: 5)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class CardFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
