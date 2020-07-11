import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/KelolaMenu/kelola_menu_edit.dart';
import 'package:apos/src/ui/KelolaMenu/kelola_menu_tambah.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KelolaMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuBloc(),
      child: KelolaMenu(),
    );
  }
}


class KelolaMenu extends StatefulWidget {
  _KelolaMenuState createState() => _KelolaMenuState();
}

class _KelolaMenuState extends State<KelolaMenu>
    with SingleTickerProviderStateMixin {
  MenuBloc _menuBloc;
  TabController controller;

  @override
  void initState() {
    _menuBloc = BlocProvider.of<MenuBloc>(context);
    _menuBloc.add(FetchingAllMenu());
    controller = TabController(length: 2, vsync: this);
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
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 2.0),
                                alignment: Alignment.center,
                                height: 60.0,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(234, 234, 234, 1),
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Pencarian Menu",
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16.0,
                                          fontFamily: 'CircularStd-Book'),
                                      prefixIcon: Icon(Icons.search,
                                          color: Colors.grey)),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(55),
                            topRight: Radius.circular(55))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70, right: 70),
                      child: TabBar(
                        controller: controller,
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(252, 195, 108, 1),
                              width: 5,
                            ),
                            insets: EdgeInsets.symmetric(horizontal: 20.0)),
                        tabs: <Widget>[
                          Tab(
                            child: Text("Makanan",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontFamily: 'CircularStd-Bold')),
                          ),
                          Tab(
                            child: Text("Minuman",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontFamily: 'CircularStd-Bold')),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              preferredSize: Size(0, 165),
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                BlocBuilder<MenuBloc, MenuState>(
                  builder: (context, state){
                    if(state is MenuLoaded){
                      return TabBarView(
                        controller: controller,
                        children: <Widget>[
                          getListMenu(state.foods),
                          getListMenu(state.drinks)
                        ],
                      );
                    } if (state is MenuEmpty) {
                      return Center(child: Text("Belum ada menu nih"));
                    } if (state is MenuLoading) {
                      return Center(child: CircularProgressIndicator());
                    } if (state is MenuError) {
                      return Center(child: Text('error'));
                    } return Center(child: Text(""));
                  }
                ),
                addMenu(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget getListMenu(List<Menu> menus){
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        itemCount: menus.length,
        itemBuilder: (BuildContext context, int index) {
          Menu menu = menus[index];
          return Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color.fromRGBO(224, 224, 224, 1),
                      width: 1.0)),
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
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(menu.name_menu,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontFamily: 'CircularStd-Bold')),
                      Row(children: <Widget>[
                        Text("Rp ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'CircularStd-Book')),
                        Text(menu.price.toString(),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditKelolaMenu(value:menu)),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
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
                              _showAlertDelete();
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
        });
  }

  void _showAlertDelete() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text("Anda yakin akan menghapusnya?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'CircularStd-Bold')),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(children: <Widget>[
                  RaisedButton(
                      padding:
                      EdgeInsets.symmetric(vertical: 18, horizontal: 50),
                      color: Color.fromRGBO(54, 58, 155, 1),
                      elevation: 5,
                      onPressed: () => Navigator.pop(context),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(100.0))),
                      child: Text("Hapus",
                          style: TextStyle(
                            color: Colors.white,
                          ))),
                  SizedBox(width: 10),
                  RaisedButton(
                      padding:
                      EdgeInsets.symmetric(vertical: 18, horizontal: 50),
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
                width: MediaQuery.of(context).size.width/1.5,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
                      Icon(
                        Icons.add,
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
                                    builder: (context) => TambahMenuPage()),
                              ).then((value){
                                _menuBloc.add(FetchingAllMenu());
                              });
                            },
                  ),
                ),
              ),
              SizedBox(
                width:5,
              ),
              Container(
                width: MediaQuery.of(context).size.width/4,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ]),
                    onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => TambahKelolaMenuOutlet()),
                              // );
                            },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
