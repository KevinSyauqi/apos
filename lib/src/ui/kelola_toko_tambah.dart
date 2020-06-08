import 'package:apos/src/bloc/userBloc.dart';
import 'package:apos/src/models/userModels.dart';
import 'package:apos/src/ui/login_page.dart';
import 'package:apos/src/ui/validasi_akun_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TambahTokoPage extends StatefulWidget {
  @override
  _TambahTokoState createState() => _TambahTokoState();
}

class _TambahTokoState extends State<TambahTokoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(54, 58, 155, 1),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height/2,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: new CircleAvatar(
                          radius: 80,
                          backgroundColor: Color.fromRGBO(252, 195, 108, 1),
                        ),
                      ),
                      new Center(
                        child: new Icon(
                          Icons.add_to_photos,
                          color: Colors.white,
                          size: 50,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ListView(
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
                              padding: const EdgeInsets.symmetric(vertical:20.0, horizontal: 40),
                              child: Column(
                                children: <Widget>[
                                  Text("Tambah Toko",
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
                                            color: Color.fromRGBO(179, 179, 183, 1),
                                          ),
                                          hintText: "Masukkan Nama Toko",
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(179, 179, 183, 1),
                                              fontSize: 13.0,
                                              fontFamily: 'CircularStd-Book'),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 16.0)),
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
                                            color: Color.fromRGBO(179, 179, 183, 1),
                                          ),
                                          hintText: "Masukkan Telepon Toko",
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(179, 179, 183, 1),
                                              fontSize: 13.0,
                                              fontFamily: 'CircularStd-Book'),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 16.0)),
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
                                            color: Color.fromRGBO(179, 179, 183, 1),
                                          ),
                                          hintText: "Masukkan Alamat Toko",
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(179, 179, 183, 1),
                                              fontSize: 13.0,
                                              fontFamily: 'CircularStd-Book'),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 16.0)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 2,
                                    padding: EdgeInsets.only(top: 5, bottom: 15),
                                    child: RaisedButton(
                                        padding: EdgeInsets.symmetric(vertical: 18),
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
                                        child: Text("Buat Toko",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ))),
                                  )
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