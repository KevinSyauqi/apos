import 'package:apos/src/bloc/pegawai/pegawai_bloc.dart';
import 'package:apos/src/bloc/pegawai/pegawai_event.dart';
import 'package:apos/src/bloc/pegawai/pegawai_state.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/KelolaPegawai/kelola_pegawai.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TambahPegawaiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PegawaiBloc(),
      child: TambahKelolaPegawai(),
    );
  }
}

class TambahKelolaPegawai extends StatefulWidget {
  @override
  _TambahKelolaPegawaiState createState() => _TambahKelolaPegawaiState();
}

class _TambahKelolaPegawaiState extends State<TambahKelolaPegawai> {
  File _image;
  final picker = ImagePicker();
  Role selectedRole;
  Outlet selectedOutlet;
  List<Role> role = [Role("Supervisor"), Role("Operator")];
  // List<Outlet> outlet = [Outlet("Kopo"), Outlet("Sarijadi")];
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final statusController = TextEditingController();

  List<DropdownMenuItem> generateItemsRole(List<Role> role) {
    List<DropdownMenuItem> items = [];
    for (var item in role) {
      items.add(DropdownMenuItem(
        child: Text(item.name),
        value: item,
      ));
    }
    return items;
  }

  // List<DropdownOutletItem> generateItemsOutlet(List<Outlet> role) {
  //   List<DropdownOutletItem> items = [];
  //   for (var item in role) {
  //     items.add(DropdownOutletItem(
  //       child: Text(item.name),
  //       value: item,
  //     ));
  //   }
  //   return items;
  // }

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
    _onAddPegawaiFormPressed() {
      BlocProvider.of<PegawaiBloc>(context).add(AddPegawaiButtonFormPressed(
          name_user: nameController.text,
          role: selectedRole.name,
          id_outlet: "4069798d529343d59da680b1336d7dd6",
          username: usernameController.text,
          password_user: passwordController.text,
          email_user: emailController.text,
          phone_user: phoneController.text));
    }

    return BlocBuilder<PegawaiBloc, PegawaiState>(
      builder: (context, state) {
        if (state is PegawaiAddSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pop(context);
          });
        }

        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Tambah Pegawai",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'CircularStd-Bold'),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            extendBodyBehindAppBar: true,
            body: ModalProgressHUD(
              child: Container(
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
                                    Icons.people,
                                    color: Colors.white,
                                    size: 80,
                                  )),
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
                            height: MediaQuery.of(context).size.height / 1.7,
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
                                        // Nama Pegawai
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: TextField(
                                            controller: nameController,
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.people,
                                                  color: Color.fromRGBO(
                                                      179, 179, 183, 1),
                                                ),
                                                hintText: "Nama Pegawai",
                                                hintStyle: TextStyle(
                                                    color: Color.fromRGBO(
                                                        179, 179, 183, 1),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'CircularStd-Book'),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 16.0)),
                                          ),
                                        ),
                                        //Username
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: TextField(
                                            controller: usernameController,
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.contacts,
                                                  color: Color.fromRGBO(
                                                      179, 179, 183, 1),
                                                ),
                                                hintText: "Username Pegawai",
                                                hintStyle: TextStyle(
                                                    color: Color.fromRGBO(
                                                        179, 179, 183, 1),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'CircularStd-Book'),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 16.0)),
                                          ),
                                        ),
                                        //Email
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: TextField(
                                            controller: emailController,
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.email,
                                                  color: Color.fromRGBO(
                                                      179, 179, 183, 1),
                                                ),
                                                hintText: "Email Pegawai",
                                                hintStyle: TextStyle(
                                                    color: Color.fromRGBO(
                                                        179, 179, 183, 1),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'CircularStd-Book'),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 16.0)),
                                          ),
                                        ),
                                        //Password
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: TextField(
                                            obscureText: true,
                                            controller: passwordController,
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.lock,
                                                  color: Color.fromRGBO(
                                                      179, 179, 183, 1),
                                                ),
                                                hintText: "Password Pegawai",
                                                hintStyle: TextStyle(
                                                    color: Color.fromRGBO(
                                                        179, 179, 183, 1),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'CircularStd-Book'),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 16.0)),
                                          ),
                                        ),
                                        //Username
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: TextField(
                                            controller: phoneController,
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.phone,
                                                  color: Color.fromRGBO(
                                                      179, 179, 183, 1),
                                                ),
                                                hintText: "No Telepon Pegawai",
                                                hintStyle: TextStyle(
                                                    color: Color.fromRGBO(
                                                        179, 179, 183, 1),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'CircularStd-Book'),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 16.0)),
                                          ),
                                        ),
                                        //Role
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            child: DropdownButtonFormField(
                                              decoration:
                                                  InputDecoration.collapsed(
                                                hintText: 'Role Jabatan',
                                                hintStyle: TextStyle(
                                                    color: Color.fromRGBO(
                                                        179, 179, 183, 1),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'CircularStd-Book'),
                                              ),
                                              isExpanded: true,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'CircularStd-Book'),
                                              value: selectedRole,
                                              items: generateItemsRole(role),
                                              onChanged: (item) {
                                                setState(() {
                                                  selectedRole = item;
                                                });
                                              },
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          padding: EdgeInsets.only(
                                              top: 0, bottom: 0),
                                          child: RaisedButton(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 18),
                                              color: Color.fromRGBO(
                                                  54, 58, 155, 1),
                                              elevation: 5,
                                              onPressed: () {
                                                state is! PegawaiAddLoading
                                                    ? _onAddPegawaiFormPressed()
                                                    : null;
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100.0))),
                                              child: Text("Tambah",
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
              ),
              inAsyncCall: state is PegawaiAddLoading,
              opacity: 0.7,
              color: Color.fromRGBO(54, 58, 155, 1),
            ));
      },
    );
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

class Role {
  String name;
  Role(this.name);
}

// class Outlet {
//   String name;
//   Outlet(this.name);
// }
