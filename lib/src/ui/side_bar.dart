import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/ui/ManageMenu/manage_menu_page.dart';
import 'package:apos/src/ui/ManageOrder/list_order_page.dart';
import 'package:apos/src/ui/History/history_page.dart';
import 'package:apos/src/ui/ManageOrder//manage_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  HomeBloc _homeBloc;
  String name_user = "";
  String role = "";

  getNameUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name_user = prefs.getString("name_user");
    String role = prefs.getString("role");
    setState(() {
      this.name_user = name_user;
      this.role = role[0].toUpperCase()+role.substring(1);
    });
  }

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    getNameUser();
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.5,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color.fromRGBO(252, 195, 108, 1),
                        Color.fromRGBO(253, 166, 125, 1),
                      ])),
                  child: Container(
                    // margin: EdgeInsets.symmetric(vertical:1),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50.0,
                              child: FaIcon(
                                FontAwesomeIcons.userAlt,
                                size: 35,
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(this.name_user,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontFamily: 'CircularStd-Bold')),
                              Text(this.role,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'CircularStd-Book'))
                            ],
                          )
                        ]),
                  ),
                ),
              ),
              ListTile(
                leading: IconTheme(
                    data: IconThemeData(color: Colors.black),
                    child: FaIcon(FontAwesomeIcons.desktop, size: 20,)),
                title: Text("Dashboard",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'CircularStd-Bold')),
                onTap: () async {
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 300));
                  _homeBloc.add(HomeDashboardPageLoad());
                },
              ),
              
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(224, 224, 224, 1),
                              width: 1.0))),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10)),
              ListTile(
                leading: IconTheme(
                    data: IconThemeData(color: Colors.black),
                    child: FaIcon(FontAwesomeIcons.clipboard)),
                title: Text("Kelola Pesanan",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'CircularStd-Bold')),
                onTap: () async {
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 300));
                  _homeBloc.add(HomeTransactionPageLoad());
                },
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(224, 224, 224, 1),
                              width: 1.0))),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10)),
              ListTile(
                leading: IconTheme(
                    data: IconThemeData(color: Colors.black),
                    child: Icon(Icons.add_shopping_cart)),
                title: Text("Checkout",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'CircularStd-Bold')),
                onTap: () async {
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 300));
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListOrderPage(),
                            ));
                },
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(224, 224, 224, 1),
                              width: 1.0))),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10)),
              (this.role == "Manager") ? ListTile(
                leading: IconTheme(
                    data: IconThemeData(color: Colors.black),
                    child: Icon(Icons.restaurant)),
                title: Text("Kelola Menu",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'CircularStd-Bold')),
                onTap: () async {
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 300));
                  _homeBloc.add(HomeMenuPageLoad());
                },
              ) : Center(),
              (this.role == "manager") ? Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(224, 224, 224, 1),
                              width: 1.0))),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10)) : Center(),
              (this.role == "Manager") ? ListTile(
                leading: IconTheme(
                    data: IconThemeData(color: Colors.black),
                    child: FaIcon(FontAwesomeIcons.cubes)),
                title: Text("Kelola Stok Menu",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'CircularStd-Bold')),
                onTap: () async {
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 300));
                  _homeBloc.add(HomeManageStockPageLoad());
                },
              ) : Center(),
              (this.role == "Manager") ? Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(224, 224, 224, 1),
                              width: 1.0))),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10)) : Center(),
              (this.role == "Manager") ? ListTile(
                leading: IconTheme(
                    data: IconThemeData(color: Colors.black),
                    child: FaIcon(FontAwesomeIcons.chartBar)),
                title: Text("Laporan Penjualan",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'CircularStd-Bold')),
                onTap: () async {
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 300));
                  _homeBloc.add(HomeReportPageLoad());
                },
              ) : Center(),
              (this.role == "Manager") ? Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(224, 224, 224, 1),
                              width: 1.0))),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10)) : Center(),
              (this.role == "Manager") ? ListTile(
                leading: IconTheme(
                    data: IconThemeData(color: Colors.black),
                    child: FaIcon(FontAwesomeIcons.calendarCheck)),
                title: Text("Prediksi Penjualan",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'CircularStd-Bold')),
                onTap: () async {
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 300));
                  _homeBloc.add(HomePredictionPageLoad());
                },
              ) : Center(),
              (this.role == "Manager") ? Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(224, 224, 224, 1),
                              width: 1.0))),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10)) : Center(),
              ListTile(
                leading: IconTheme(
                    data: IconThemeData(color: Colors.black),
                    child: Icon(Icons.history)),
                title: Text("Riwayat Transaksi",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'CircularStd-Bold')),
                onTap: () async {
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 300));
                  _homeBloc.add(HomeHistoryPageLoad());
                },
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(224, 224, 224, 1),
                              width: 1.0))),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10)),
              ListTile(
                leading: IconTheme(
                    data: IconThemeData(color: Colors.black),
                    child: Icon(Icons.exit_to_app)),
                title: Text("Logout",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'CircularStd-Bold')),
                onTap: () {},
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(224, 224, 224, 1),
                              width: 1.0))),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10)),
            ],
          )
        ],
      ),
    );
  }
}
