
import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/ui/ManageMenu/manage_menu_page.dart';
import 'package:apos/src/ui/Report/report_page.dart';
import 'package:apos/src/ui/History/riwayat_transaksi.dart';
import 'package:apos/src/ui/ManageOrder//manage_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
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
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text("Nama Pengguna",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontFamily: 'CircularStd-Bold')),
                              Text("Role Pengguna",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
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
                    child: Icon(Icons.dashboard)),
                title: Text("Dasbor",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'CircularStd-Bold')),
                onTap: () async{
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
                    child: Icon(Icons.add_shopping_cart)),
                title: Text("Kelola Pesanan",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'CircularStd-Bold')),
                onTap: () async{
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
                    child: Icon(Icons.fastfood)),
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
                    child: Icon(Icons.list)),
                title: Text("Laporan Penjualan",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'CircularStd-Bold')),
                onTap: () async{
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 300));
                  _homeBloc.add(HomeReportPageLoad());
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
                    child: Icon(Icons.list)),
                title: Text("Prediksi Penjualan",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'CircularStd-Bold')),
                onTap: () async{
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 300));
                  _homeBloc.add(HomePredictionPageLoad());
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
                    child: Icon(Icons.settings)),
                title: Text("Edit Profile",
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
