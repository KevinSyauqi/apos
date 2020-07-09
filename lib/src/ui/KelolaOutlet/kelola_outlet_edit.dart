import 'package:apos/src/models/outletModels.dart';
import 'package:apos/src/ui/KelolaOutlet/kelola_outlet.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditKelolaOutlet extends StatefulWidget {
  final Outlet value;
  EditKelolaOutlet({Key key, this.value}) : super(key: key);
  @override
  _EditKelolaOutletState createState() => _EditKelolaOutletState();
}

class _EditKelolaOutletState extends State<EditKelolaOutlet> {
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
              title: Text(
                "Edit Outlet",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'CircularStd-Bold'),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
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
                            child: Icon(
                              Icons.store,
                              color: Colors.white,
                              size: 80,
                            )),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.3,
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.3,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(
                      _image,
                      fit: BoxFit.cover,
                    )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 35),
                        height: MediaQuery.of(context).size.height / 6,
                        child: FloatingActionButton(
                          backgroundColor: Color.fromRGBO(54, 58, 155, 1),
                          onPressed: () {
                            _showAlertImage();
                          },
                          tooltip: 'Ambil Gambar',
                          child: Icon(Icons.camera_alt),
                        ),
                      ),
                    ]),
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
                              // Nama Menu
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: TextFormField(
                                  initialValue: '${widget.value.name_outlet}',
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
                                child: TextFormField(
                                  initialValue: '${widget.value.address_outlet}',
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
                                child: TextFormField(
                                  initialValue: '${widget.value.phone_outlet}',
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

                              SizedBox(
                                height: 20,
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
                                                KelolaOutlet()),
                                      );
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100.0))),
                                    child: Text("Simpan",
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

}

class Category {
  String name;
  Category(this.name);
}
