import 'dart:convert';
import 'dart:math';

import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/ManageMenu//manage_menu_add_page.dart';
import 'package:apos/src/ui/ManageMenu/manage_menu_edit_page.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManageMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuBloc(),
      child: ManageMenu(),
    );
  }
}

class ManageMenu extends StatefulWidget {
  _ManageMenuState createState() => _ManageMenuState();
}

class _ManageMenuState extends State<ManageMenu>
    with SingleTickerProviderStateMixin {
  MenuBloc _menuBloc;
  TabController controller;

  _onUpdateButtonPressed(Menu menu) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ManageMenuEditPage(menu: menu)));
  }

  @override
  void initState() {
    _menuBloc = BlocProvider.of<MenuBloc>(context);
    _menuBloc.add(FetchingAllMenu());
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _menuBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Kelola Menu",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'CircularStd-Bold'),
            ),
            bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TabBar(
                          isScrollable: true,
                          controller: controller,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(252, 195, 108, 1),
                                width: 5,
                              ),
                              insets: EdgeInsets.symmetric(horizontal: 20.0)),
                          tabs: <Widget>[
                            Tab(
                              child: Container(
                                width: 150,
                                child: Text("Makanan"
                                    , textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontFamily: 'CircularStd-Bold')),
                              ),
                            ),
                            Tab(
                              child: Container(
                                width: 150,
                                child: Text("Minuman"
                                    , textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontFamily: 'CircularStd-Bold')),
                              ),
                            ),
                            Tab(
                              child: Text("Tidak Aktif",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'CircularStd-Bold')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              preferredSize: Size(0, 70),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(252, 195, 108, 1),
                        Color.fromRGBO(253, 166, 125, 1),
                      ])),
            ),
            elevation: 0.0,
          ),
          drawer: AppDrawer(),
          body: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Stack(
              children: <Widget>[
                BlocBuilder<MenuBloc, MenuState>(builder: (context, state) {
                  if (state is ActiveMenuSuccess) {
                    _menuBloc.add(FetchingAllMenu());
                  }
                  if (state is DeactiveMenuSuccess) {
                    _menuBloc.add(FetchingAllMenu());
                  }
                  if (state is MenuLoaded) {
                    return TabBarView(
                      controller: controller,
                      children: <Widget>[
                        getListMenu(state.foods),
                        getListMenu(state.drinks),
                        getListMenu(state.noActiveMenus)
                      ],
                    );
                  }
                  if (state is MenuEmpty) {
                    return Center(child: Text("Belum ada menu nih"));
                  }
                  if (state is MenuLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is MenuError) {
                    return Center(child: Text('error'));
                  }
                  return Center(child: Text(""));
                }),
                addMenu(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget getListMenu(List<Menu> menus) {
    if (menus.length == 0) {
      return Container(child: Center(child: Text("Menu aktif semua")));
    } else
      return Container(
        margin: EdgeInsets.only(bottom: 90),
        child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            itemCount: menus.length,
            itemBuilder: (BuildContext context, int index) {
              Menu menu = menus[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromRGBO(224, 224, 224, 1), width: 1.0)),
                  color: Color.fromRGBO(250, 250, 250, 1),
                ),
                width: double.infinity,
                height: 80,
                margin: EdgeInsets.symmetric(horizontal: 25),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 55,
                      height: 55,
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(234, 234, 234, 1),
//                      image: (menu.photo_menu != null) ? DecorationImage(image: MemoryImage(base64Decode(menu.photo_menu))):null,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            menu.name_menu,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontFamily: 'CircularStd-Bold'),
                            overflow: TextOverflow.fade,
                            softWrap: true,
                          ),
                          Row(children: <Widget>[
                            Text("Rp ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: 'CircularStd-Book')),
                            Text(
                                FlutterMoneyFormatter(
                                    amount:
                                    double.parse(menu.price.toString()))
                                    .output
                                    .withoutFractionDigits,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: 'CircularStd-Book')),
                          ])
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(54, 58, 155, 1),
                                  borderRadius: BorderRadius.circular(13)),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                iconSize: 17,
                                color: Colors.white,
                                onPressed: () {
                                  _onUpdateButtonPressed(menu);
                                },
                              ),
                            ),
                            SizedBox(width: 5),
                            (menu.is_active == true) ? Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(54, 58, 155, 1),
                                  borderRadius: BorderRadius.circular(13)),
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                iconSize: 17,
                                color: Colors.white,
                                onPressed: () {
                                  _showAlertDelete(menu.id_menu);
                                },
                              ),
                            ) : Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(54, 58, 155, 1),
                                  borderRadius: BorderRadius.circular(13)),
                              child: IconButton(
                                icon: Icon(Icons.check),
                                iconSize: 17,
                                color: Colors.white,
                                onPressed: () {
                                  _showAlertActive(menu.id_menu);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      );
  }

  void _showAlertDelete(String id_menu) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text("Anda yakin akan menonaktifkan menu ini?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'CircularStd-Bold')),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Container(width: MediaQuery.of(context).size.width,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
                    RaisedButton(
                        padding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                        color: Color.fromRGBO(54, 58, 155, 1),
                        elevation: 5,
                        onPressed: () async {
                          _menuBloc.add(DeactiveMenu(id_menu: id_menu));
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(100.0))),
                        child: Text("Nonaktifkan",
                            style: TextStyle(
                              color: Colors.white,
                            ))),
                    SizedBox(width: 10),
                    RaisedButton(
                        padding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                        color: Color.fromRGBO(234, 234, 234, 1),
                        elevation: 5,
                        onPressed: () => Navigator.pop(context),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(100.0))),
                        child: Text("Batal",
                            style: TextStyle(
                              color: Colors.black,
                            ))),
                  ]),
                ),
              )
            ],
          );
        });
  }

  void _showAlertActive(String id_menu) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text("Ingin aktifkan menu?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'CircularStd-Bold')),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
                    RaisedButton(
                        padding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                        color: Color.fromRGBO(54, 58, 155, 1),
                        elevation: 5,
                        onPressed: () async {
                          await _menuBloc.add(ActiveMenu(id_menu: id_menu));
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(100.0))),
                        child: Text("Aktifkan",
                            style: TextStyle(
                              color: Colors.white,
                            ))),
                    SizedBox(width: 10),
                    RaisedButton(
                        padding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                        color: Color.fromRGBO(234, 234, 234, 1),
                        elevation: 5,
                        onPressed: () => Navigator.pop(context),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(100.0))),
                        child: Text("Batal",
                            style: TextStyle(
                              color: Colors.black,
                            ))),
                  ]),
                ),
              )
            ],
          );
        });
  }

  Widget addMenu() {
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                // margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.plus,
                            size: 18,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Tambah Menu",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'CircularStd-Bold'),
                          )
                        ]),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageMenuAddPage()),
                      ).then((value) {
                        _menuBloc.add(FetchingAllMenu());
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
