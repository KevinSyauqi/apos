import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/ui/ManageOrder/list_order_page.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<DashboardBloc>(
        create: (context) => DashboardBloc(),
      ),
      BlocProvider<ReportBloc>(
        create: (context) => ReportBloc(),
      ),
    ], child: Dashboard());
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 1));
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  HomeBloc _homeBloc;
  ReportBloc _reportBloc;
  String name_user = "";

  getNameUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name_user = prefs.getString("name_user");
    setState(() {
      this.name_user = name_user;
    });
  }

  @override
  void initState() {
    super.initState();
    getNameUser();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _reportBloc = BlocProvider.of<ReportBloc>(context);
    _reportBloc.add(GenerateReportSales(end_date: DateTime.now()));
  }

  @override
  void dispose() {
    _reportBloc.close();
    // _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Dashboard",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontFamily: 'CircularStd-Bold'),
        ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Selamat Datang,",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'CircularStd-Book')),
                              Container(
                                child: Text(name_user,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'CircularStd-Bold')),
                                width: 80,
                              ),
                            ],
                          ),
                          Container(
                            height: 35,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(54, 58, 155, 0.8),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.calendar_today,
                                    color: Colors.white, size: 15),
                                SizedBox(width: 5),
                                Text(
                                  new DateFormat("EEEE, dd MMMM yyyy")
                                      .format(new DateTime.now()),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: 'CircularStd-Bold'),
                                )
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
                          FaIcon(FontAwesomeIcons.shoppingBasket,
                              color: Colors.black, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Total Pendapatan",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'CircularStd-Bold'),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 150,
                            child: BlocBuilder<ReportBloc, ReportState>(
                              builder: (context, state) {
                                if (state is ReportLoaded) {
                                  return Text(
                                    "Rp " +
                                        FlutterMoneyFormatter(
                                                amount: double.parse(
                                                    state.totalIncome))
                                            .output
                                            .withoutFractionDigits,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontFamily: 'CircularStd-Bold'),
                                  );
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
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
                          (MediaQuery.of(context).size.width / 8) -
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
                          Container(
                            width: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                BlocBuilder<ReportBloc, ReportState>(
                                  builder: (context, state) {
                                    if (state is ReportLoaded) {
                                      return Text(
                                        state.totalSalesMenu,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontFamily: 'CircularStd-Bold'),
                                      );
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                                
                              ],
                            ),
                          ),
                          SizedBox(width: 2),
                                Text(
                                  "Porsi",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontFamily: 'CircularStd-Bold'),
                                )
                        ],
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width / 1.8) -
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
                             Text(
                            "Profit",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'CircularStd-Bold'),
                          ),
                              SizedBox(width: 8),
                            ],
                          ),BlocBuilder<ReportBloc, ReportState>(
                                  builder: (context, state) {
                                    if (state is ReportLoaded) {
                                      return Text("Rp "+
                                        FlutterMoneyFormatter(
                                                amount: double.parse(
                                                    state.totalProfit))
                                            .output
                                            .withoutFractionDigits,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontFamily: 'CircularStd-Bold'),
                                      );
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Center(
                    child: Text(
                      "Layanan Aplikasi",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'CircularStd-Bold'),
                    ),
                  ),
                )
              ],
            ),
            preferredSize: Size(0, 285)),
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
                              _homeBloc.add(HomeTransactionPageLoad());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      252, 195, 108, 0.3),
                                                  Color.fromRGBO(
                                                      253, 166, 125, 0.3)
                                                ])),
                                      ),
                                      FaIcon(FontAwesomeIcons.clipboard,
                                          size: 30)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Kelola Pesanan",
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
                              _homeBloc.add(HomeMenuPageLoad());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      252, 195, 108, 0.3),
                                                  Color.fromRGBO(
                                                      253, 166, 125, 0.3)
                                                ])),
                                      ),
                                      Icon(Icons.restaurant, size: 30)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Kelola Menu",
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListOrderPage(),
                                  ));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      252, 195, 108, 0.3),
                                                  Color.fromRGBO(
                                                      253, 166, 125, 0.3)
                                                ])),
                                      ),
                                      Icon(Icons.add_shopping_cart, size: 30)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Checkout Pesanan",
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
                              _homeBloc.add(HomeManageStockPageLoad());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      252, 195, 108, 0.3),
                                                  Color.fromRGBO(
                                                      253, 166, 125, 0.3)
                                                ])),
                                      ),
                                      FaIcon(FontAwesomeIcons.cubes, size: 30)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Kelola Stok Menu",
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
                                borderRadius: BorderRadius.circular(10.0)),
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      252, 195, 108, 0.3),
                                                  Color.fromRGBO(
                                                      253, 166, 125, 0.3)
                                                ])),
                                      ),
                                      FaIcon(FontAwesomeIcons.chartBar,
                                          size: 30)
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
                              _homeBloc.add(HomePredictionPageLoad());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      252, 195, 108, 0.3),
                                                  Color.fromRGBO(
                                                      253, 166, 125, 0.3)
                                                ])),
                                      ),
                                      FaIcon(FontAwesomeIcons.calendarCheck,
                                          size: 30)
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
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: MediaQuery.of(context).size.width / 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              _homeBloc.add(HomeHistoryPageLoad());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      252, 195, 108, 0.3),
                                                  Color.fromRGBO(
                                                      253, 166, 125, 0.3)
                                                ])),
                                      ),
                                      Icon(Icons.history, size: 30)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Riwayat Transaksi",
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
