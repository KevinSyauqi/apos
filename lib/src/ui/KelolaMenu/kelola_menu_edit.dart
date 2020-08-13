import 'dart:convert';

import 'package:apos/src/models/menuModels.dart';
import 'package:apos/src/ui/KelolaMenu/kelola_menu.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditKelolaMenu extends StatefulWidget {
  final Menu value;
  EditKelolaMenu({Key key, this.value}) : super(key: key);
  @override
  _EditKelolaMenuState createState() => _EditKelolaMenuState();
}

class _EditKelolaMenuState extends State<EditKelolaMenu> {
  bool isStock = false;
  File _image;
  final picker = ImagePicker();
  String base64img;
  Category selectedCategory;
  List<Category> category = [Category("Makanan"), Category("Minuman")];
  Widget stockForm = Card();

  List<DropdownMenuItem> generateItems(List<Category> category) {
    List<DropdownMenuItem> items = [];
    for (var item in category) {
      items.add(DropdownMenuItem(
        child: Text(item.name),
        value: item,
      ));
    }
    return items;
  }

  Future getImageCamera() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      base64img = base64Encode(_image.readAsBytesSync());
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
            "Edit Menu",
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
                              Icons.fastfood,
                              color: Colors.white,
                              size: 80,
                            )),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.1,
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height / 2.1,
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
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  child: FloatingActionButton(
                                    backgroundColor:
                                        Color.fromRGBO(54, 58, 155, 1),
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
                                  vertical: 30.0, horizontal: 40),
                              child: Column(
                                children: <Widget>[
                                  // Nama Menu
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: TextFormField(
                                      initialValue: '${widget.value.name_menu}',
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.fastfood,
                                            color: Color.fromRGBO(
                                                179, 179, 183, 1),
                                          ),
                                          hintText: "Nama Menu",
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
                                  // Harga Menu
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: TextFormField(
                                      initialValue: '${widget.value.price}',
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.account_balance_wallet,
                                            color: Color.fromRGBO(
                                                179, 179, 183, 1),
                                          ),
                                          hintText: "Harga Menu",
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
                                  // Harga Dasar
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: TextFormField(
                                      initialValue: '${widget.value.cog}',
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.account_balance_wallet,
                                            color: Color.fromRGBO(
                                                179, 179, 183, 1),
                                          ),
                                          hintText:
                                              "Harga Dasar (Tidak Wajib Diisi)",
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
                                  // Kategori Menu
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 20),
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration.collapsed(
                                          hintText: 'Kategori Menu',
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  179, 179, 183, 1),
                                              fontSize: 13.0,
                                              fontFamily: 'CircularStd-Book'),
                                        ),
                                        isExpanded: true,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            fontFamily: 'CircularStd-Book'),
                                        value: selectedCategory,
                                        items: generateItems(category),
                                        onChanged: (item) {
                                          setState(() {
                                            selectedCategory = item;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  // Deskripsi Menu
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: TextFormField(
                                      initialValue:
                                          '${widget.value.description}',
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.description,
                                            color: Color.fromRGBO(
                                                179, 179, 183, 1),
                                          ),
                                          hintText: "Deskripsi Menu",
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
                                  //Switch Stok
                                  Container(
                                    child: Row(children: <Widget>[
                                      Text(
                                        "Aktifkan Stok Menu",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                            fontFamily: 'CircularStd-Bold'),
                                      ),
                                      SizedBox(width: 10),
                                      Transform.scale(
                                        scale: 0.8,
                                        child: CupertinoSwitch(
                                            activeColor: Colors.white,
                                            value: isStock,
                                            onChanged: (newValue) {
                                              isStock = newValue;
                                              setState(() {
                                                if (isStock)
                                                  stockForm = Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              prefixIcon: Icon(
                                                                Icons
                                                                    .card_giftcard,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        179,
                                                                        179,
                                                                        183,
                                                                        1),
                                                              ),
                                                              hintText:
                                                                  "Stok Menu",
                                                              hintStyle: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          179,
                                                                          179,
                                                                          183,
                                                                          1),
                                                                  fontSize:
                                                                      13.0,
                                                                  fontFamily:
                                                                      'CircularStd-Book'),
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              border: OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20))),
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          20.0,
                                                                      vertical:
                                                                          16.0)),
                                                    ),
                                                  );
                                                else {
                                                  stockForm = Card();
                                                }
                                              });
                                            }),
                                      ),
                                      SizedBox(width: 10),
                                      // stockForm,
                                    ]),
                                  ),
                                  // Stok Menu
                                  AnimatedSwitcher(
                                      child: stockForm,
                                      duration: Duration(seconds: 2)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    padding:
                                        EdgeInsets.only(top: 5, bottom: 15),
                                    child: RaisedButton(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 18),
                                        color: Color.fromRGBO(54, 58, 155, 1),
                                        elevation: 5,
                                        onPressed: () async {
                                          // state is! MenuAddLoading ? await _onAddMenuFormPressed():null;
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
