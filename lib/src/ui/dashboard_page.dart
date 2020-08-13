import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DashboardBloc(), child: Dashboard());
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Dasbor",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontFamily: 'CircularStd-Bold'),
        ),
        actions: <Widget>[
          Container(
            height: 40,
            width: 200,
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.store, color: Colors.white, size: 20),
                SizedBox(width: 3),
                Text(
                  "Lapau Bukittinggi (Pusat)",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontFamily: 'CircularStd-Bold'),
                )
              ],
            ),
          ),
          SizedBox(width: 8),
        ],
        bottom: PreferredSize(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 15,
                      vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Selamat Datang,",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'CircularStd-Book')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text("Annisa Fathana",
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'CircularStd-Bold')),
                            width: 150,
                          ),
                          Container(
                            height: 30,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(54, 58, 155, 0.8),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.calendar_today,color: Colors.white, size: 15),
                                SizedBox(width: 5),
                                Text("Minggu, 20 Desember 2020", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: 'CircularStd-Bold'
                                ),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 15,
                      vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 5.0,
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.account_balance_wallet,
                              color: Colors.black, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Penjualan",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'CircularStd-Bold'),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Rp",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'CircularStd-Bold'),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "2.450.000",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'CircularStd-Bold'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: (MediaQuery.of(context).size.width / 2) -
                          (MediaQuery.of(context).size.width / 15) -
                          5,
                      height: MediaQuery.of(context).size.height / 15,
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 15, 5, 5, 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 5.0,
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.restaurant_menu,
                                  color: Colors.black, size: 20),
                              SizedBox(width: 8),
                            ],
                          ),
                          Text(
                            "23",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'CircularStd-Bold'),
                          ),
                          SizedBox(width: 8),
                          Column(
                            children: <Widget>[
                              Text(
                                "Menu\nTerjual",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'CircularStd-Bold'),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width / 2) -
                          (MediaQuery.of(context).size.width / 15) -
                          5,
                      height: MediaQuery.of(context).size.height / 15,
                      margin: EdgeInsets.fromLTRB(
                          5, 5, MediaQuery.of(context).size.width / 15, 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 5.0,
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.description,
                                  color: Colors.black, size: 20),
                              SizedBox(width: 8),
                            ],
                          ),
                          Text(
                            "12",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'CircularStd-Bold'),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Transaksi",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'CircularStd-Bold'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(55),
                          topRight: Radius.circular(55))),
                  child: Center(
                    child: Text(
                      "Layanan Aplikasi",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'CircularStd-Bold'),
                    ),
                  ),
                )
              ],
            ),
            preferredSize: Size(0, 270)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromRGBO(252, 195, 108, 1),
                Color.fromRGBO(253, 166, 125, 1)
              ])),
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: MediaQuery.of(context).size.width / 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  blurRadius: 8)
                            ]),
                        child: ButtonTheme(
                          height: 100,
                          padding: EdgeInsets.all(10),
                          highlightColor: Color.fromRGBO(54, 58, 155, 0.1),
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () {
                              _homeBloc.add(HomeMenuPageLoad());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            color: Colors.white,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      252, 195, 108, 0.3),
                                                  Color.fromRGBO(253, 166, 125, 0.3)
                                                ])),
                                      ),
                                      Icon(Icons.restaurant_menu, size: 30)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Kelola\nMenu",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'CircularStd-Bold',
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  blurRadius: 8)
                            ]),
                        child: ButtonTheme(
                          height: 100,
                          padding: EdgeInsets.all(10),
                          highlightColor: Color.fromRGBO(54, 58, 155, 0.1),
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () {
                              _homeBloc.add(HomeOutletPageLoad());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            color: Colors.white,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      252, 195, 108, 0.3),
                                                  Color.fromRGBO(253, 166, 125, 0.3)
                                                ])),
                                      ),
                                      Icon(Icons.store, size: 30)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Kelola Outlet",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'CircularStd-Bold',
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  blurRadius: 8)
                            ]),
                        child: ButtonTheme(
                          height: 100,
                          padding: EdgeInsets.all(10),
                          highlightColor: Color.fromRGBO(54, 58, 155, 0.1),
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () {
                              _homeBloc.add(HomeEmployeePageLoad());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            color: Colors.white,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      252, 195, 108, 0.3),
                                                  Color.fromRGBO(253, 166, 125, 0.3)
                                                ])),
                                      ),
                                      Icon(Icons.people, size: 30)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Kelola Pegawai",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'CircularStd-Bold',
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: MediaQuery.of(context).size.width / 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  blurRadius: 8)
                            ]),
                        child: ButtonTheme(
                          height: 100,
                          padding: EdgeInsets.all(10),
                          highlightColor: Color.fromRGBO(54, 58, 155, 0.1),
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () {
                              _homeBloc.add(HomeTransactionPageLoad());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            color: Colors.white,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      252, 195, 108, 0.3),
                                                  Color.fromRGBO(253, 166, 125, 0.3)
                                                ])),
                                      ),
                                      Icon(Icons.shopping_basket, size: 30)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Transaksi",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'CircularStd-Bold',
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  blurRadius: 8)
                            ]),
                        child: ButtonTheme(
                          height: 100,
                          padding: EdgeInsets.all(10),
                          highlightColor: Color.fromRGBO(54, 58, 155, 0.1),
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () {
                              _homeBloc.add(HomeReportPageLoad());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            color: Colors.white,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      252, 195, 108, 0.3),
                                                  Color.fromRGBO(253, 166, 125, 0.3)
                                                ])),
                                      ),
                                      Icon(Icons.insert_chart, size: 30)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Laporan Penjualan",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'CircularStd-Bold',
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  blurRadius: 8)
                            ]),
                        child: ButtonTheme(
                          height: 100,
                          padding: EdgeInsets.all(10),
                          highlightColor: Color.fromRGBO(54, 58, 155, 0.1),
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () {
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            color: Colors.white,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      252, 195, 108, 0.3),
                                                  Color.fromRGBO(253, 166, 125, 0.3)
                                                ])),
                                      ),
                                      Icon(Icons.av_timer, size: 30)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Prediksi Penjualan",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'CircularStd-Bold',
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            startSalling()
          ],
        ),
      ),
    );
  }

  Widget startSalling() {
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
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
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
                          Text(
                            "Mulai Jualan",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'CircularStd-Bold'),
                          )
                        ]),
                    onPressed: () {
                      _homeBloc.add(HomeTransactionPageLoad());
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
