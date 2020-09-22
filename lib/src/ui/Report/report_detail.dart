import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/History/history_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

import '../side_bar.dart';

class ReportDetailPage extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;

  ReportDetailPage({this.startDate, this.endDate});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReportBloc>(
      create: (context) => ReportBloc()
        ..add(GetReportDetail(start_date: startDate, end_date: endDate)),
      child: ReportDetail(),
    );
  }
}

class ReportDetail extends StatefulWidget {
  _ReportDetailState createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 1));
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  String selectedStartDate = "Periode Awal";
  String selectedEndDate = "Periode Akhir";
  ReportBloc _reportBloc;

  @override
  void initState() {
    _reportBloc = BlocProvider.of<ReportBloc>(context);
  }

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2021));
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
        _reportBloc.add(GetReportDetail(start_date: _startDate, end_date: _endDate));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Detail Laporan Penjualan",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'CircularStd-Bold'),
            ),
            bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      await displayDateRangePicker(context);
                      print(_startDate);
                      print(_startDate);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Container(
                            padding: EdgeInsets.only(left: 15),
                            height: 55,
                            child: Row(
                              children: <Widget>[
                                Container(child: Icon(Icons.date_range)),
                                SizedBox(width: 10),
                                InkWell(
                          child: BlocBuilder<ReportBloc,
                              ReportState>(
                            builder: (context, state) {
                              if (state is ReportDetailLoaded) {
                                imageCache.clearLiveImages();
                                _startDate = state.startDate;
                                _endDate = state.endDate;
                                this.selectedStartDate =
                                    DateFormat('yyyy/MM/dd').format(state.startDate);
                                this.selectedEndDate =
                                    DateFormat('yyyy/MM/dd').format(state.endDate);
                                return Row(
                                  children: <Widget>[
                                    Text(
                                      selectedStartDate,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.0,
                                          fontFamily:
                                          'CircularStd-Book'),
                                    ),
                                    Text(
                                      " - ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.0,
                                          fontFamily:
                                          'CircularStd-Book'),
                                    ),
                                    Text(
                                      selectedEndDate,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.0,
                                          fontFamily:
                                          'CircularStd-Book'),
                                    ),
                                  ],
                                );
                              }
                              return Center(
                                  child:
                                  CircularProgressIndicator());
                            },
                          ),
                        ),
                              ],
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                  )
                ],
              ),
              preferredSize: Size(0, 125),
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
          body: BlocBuilder<ReportBloc, ReportState>(
            builder: (context, state) {
              if (state is ReportDetailLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ReportDetailLoaded) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      ListView.builder(
                          itemCount: state.listReport.length,
                          itemBuilder: (_, index) {
                            Report report = state.listReport[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromRGBO(224, 224, 224, 1),
                                        width: 1.0)),
                                color: Color.fromRGBO(250, 250, 250, 1),
                              ),
                              width: double.infinity,
                              height: 100,
                              margin: EdgeInsets.symmetric(horizontal: 25),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 55,
                                    height: 55,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage("https://apos-server-kota202.et.r.appspot.com/manageMenu/photo?id_menu="+report.id_menu)
                                      ),
                                      color: Color.fromRGBO(234, 234, 234, 1),
//                      image: (menu.photo_menu != null) ? DecorationImage(image: MemoryImage(base64Decode(menu.photo_menu))):null,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          report.name_menu,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontFamily: 'CircularStd-Bold'),
                                          overflow: TextOverflow.fade,
                                          softWrap: true,
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              child: FaIcon(
                                            FontAwesomeIcons.coins,
                                            size: 15,
                                            color: Colors.black87,
                                          )),
                                          Text("Rp "+
                                              FlutterMoneyFormatter(
                                                  amount: double.parse(report.income.toString()))
                                                  .output.withoutFractionDigits,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontFamily: 'CircularStd-Bold'),
                                            overflow: TextOverflow.fade,
                                            softWrap: true,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              child: FaIcon(
                                                FontAwesomeIcons.hamburger,
                                                size: 15,
                                                color: Colors.black87,
                                              )),
                                          Text(report.quantity.toString() + " porsi",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontFamily: 'CircularStd-Bold'),
                                            overflow: TextOverflow.fade,
                                            softWrap: true,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              child: FaIcon(
                                                FontAwesomeIcons.cashRegister,
                                                size: 15,
                                                color: Colors.black87,
                                              )),
                                          Text("Rp "+
                                              FlutterMoneyFormatter(
                                                  amount: double.parse(report.profit.toString()))
                                                  .output.withoutFractionDigits,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontFamily: 'CircularStd-Bold'),
                                            overflow: TextOverflow.fade,
                                            softWrap: true,
                                          )
                                        ],
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                );
              }
              return Center(child: Text("History Empty"));
            },
          ),
        ),
      ]),
    );
  }
}
