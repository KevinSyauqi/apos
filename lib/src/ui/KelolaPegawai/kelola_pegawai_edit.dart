import 'package:apos/src/ui/KelolaPegawai/kelola_pegawai.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditKelolaPegawai extends StatefulWidget {
  @override
  _EditKelolaPegawaiState createState() => _EditKelolaPegawaiState();
}

class _EditKelolaPegawaiState extends State<EditKelolaPegawai> {
  File _image;
  final picker = ImagePicker();

  Future getImageCamera() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImageGallery() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void _showAlertImage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text("Ambil foto melalui?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'CircularStd-Bold')),
            actions: <Widget>[
              Row(children: <Widget>[
                RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                    color: Color.fromRGBO(54, 58, 155, 1),
                    elevation: 5,
                    onPressed: getImageGallery,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0))),
                    child: Text("Galeri",
                        style: TextStyle(
                          color: Colors.white,
                        ))),
                SizedBox(width: 10),
                RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                    color: Color.fromRGBO(54, 58, 155, 1),
                    elevation: 5,
                    onPressed: getImageCamera,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0))),
                    child: Text("Kamera",
                        style: TextStyle(
                          color: Colors.white,
                        ))),
              ])
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: _image == null
                ? Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(234, 234, 234, 1),
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text("Belum ada foto",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: 'CircularStd-Bold'))),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(
                      _image,
                      fit: BoxFit.cover,
                    )),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 10,
            right: 40,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: FloatingActionButton(
                backgroundColor: Color.fromRGBO(54, 58, 155, 1),
                onPressed: () {
                  _showAlertImage();
                },
                tooltip: 'Ambil Gambar',
                child: Icon(Icons.camera_alt),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40),
                          child: Column(
                            children: <Widget>[
                              Text("Detail Outlet",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36.0,
                                      fontFamily: 'CircularStd-Bold')),
                              SizedBox(height: 5),
                              // Nama Menu
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.store_mall_directory,
                                        color: Color.fromRGBO(179, 179, 183, 1),
                                      ),
                                      hintText: "Nama Outlet",
                                      hintStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(179, 179, 183, 1),
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

                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.add_location,
                                        color: Color.fromRGBO(179, 179, 183, 1),
                                      ),
                                      hintText: "Alamat Outlet",
                                      hintStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(179, 179, 183, 1),
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

                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: Color.fromRGBO(179, 179, 183, 1),
                                      ),
                                      hintText: "No. Telepon",
                                      hintStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(179, 179, 183, 1),
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

                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.description,
                                        color: Color.fromRGBO(179, 179, 183, 1),
                                      ),
                                      hintText: "Deskripsi Outlet",
                                      hintStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(179, 179, 183, 1),
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
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                padding: EdgeInsets.only(top: 0, bottom: 0),
                                child: RaisedButton(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    color: Color.fromRGBO(54, 58, 155, 1),
                                    elevation: 5,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                KelolaPegawai()),
                                      );
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100.0))),
                                    child: Text("Edit",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ))),
                              ),
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

  Widget getImage() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                margin: EdgeInsets.fromLTRB(20, 20, 10, 20),
                alignment: Alignment.center,
                child: ButtonTheme(
                  height: 50,
                  padding: EdgeInsets.all(15),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Color.fromRGBO(54, 58, 155, 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "2 pesanan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: 'CircularStd-Book'),
                              ),
                            ],
                          ),
                          Text(
                            "Rp 10.000",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'CircularStd-Bold'),
                          ),
                        ]),
                    onPressed: () {},
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 7,
                height: 50,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(54, 58, 155, 1),
                    borderRadius: BorderRadius.circular(19)),
                child: IconButton(
                  icon: Icon(Icons.view_list),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Category {
  String name;
  Category(this.name);
}
