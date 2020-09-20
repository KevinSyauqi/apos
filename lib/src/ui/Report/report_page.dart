import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/History/history_detail.dart';
import 'package:apos/src/ui/Report/report_detail.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apos/src/bloc/bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportBloc(),
      child: ReportSales(),
    );
  }
}

class ReportSales extends StatefulWidget {
  _ReportSalesState createState() => _ReportSalesState();
}

class _ReportSalesState extends State<ReportSales>
    with SingleTickerProviderStateMixin {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 1));
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  String selectedStartDate = "Periode Awal";
  String selectedEndDate = "Periode Akhir";

  ReportBloc _reportBloc;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  void initState() {
    _reportBloc = BlocProvider.of<ReportBloc>(context);
    _reportBloc.add(GenerateReportSales(end_date: DateTime.now()));
    super.initState();
  }

  @override
  void dispose() {
    _reportBloc.close();
    // controller.dispose();
    super.dispose();
  }

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2021));
    if (picked != null && picked.length == 2) {
      _startDate = picked[0];
      _endDate = picked[1];
      _reportBloc
          .add(GenerateReportSales(start_date: _startDate, end_date: _endDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      SalesData("2019-03-01", 1000),
      SalesData("", 1600),
      SalesData("", 1000),
      SalesData("", 4000),
      SalesData("", 3000),
      SalesData("", 1500),
      SalesData("2019-04-30", 2400)
    ];

//    var series = [
//      new charts.Series(
//          id: "Sales",
//          data: data,
//          domainFn: (SalesData sales, _) => sales.,
//          measureFn: (SalesData sales,_) => sales.sales)
//    ];

    return Scaffold(
      drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              pinned: true,
              expandedHeight: 320.0,
              backgroundColor: Color.fromRGBO(252, 195, 108, 1),
              title: Text(
                "Laporan Penjualan",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'CircularStd-Bold'),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Color.fromRGBO(252, 195, 108, 1),
                            Color.fromRGBO(253, 166, 125, 1),
                          ])),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                                            if (state is ReportLoaded) {
                                              _startDate = state.startDate;
                                              _endDate = state.endDate;
                                              this.selectedStartDate =
                                                  DateFormat('yyyy/MM/dd')
                                                      .format(state.startDate);
                                              this.selectedEndDate =
                                                  DateFormat('yyyy/MM/dd')
                                                      .format(state.endDate);

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
                        SizedBox(height: 5),
                        Stack(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(height: 70),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(250, 250, 250, 10),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(55),
                                          topRight: Radius.circular(55))),
                                ),
                                Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.height,
                                  color: Color.fromRGBO(250, 250, 250, 1),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              height: 178,
                              child: Card(
                                elevation: 10,
                                shadowColor: Color.fromRGBO(0, 0, 0, 0.2),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              child: Icon(Icons.attach_money,
                                                  size: 20)),
                                          SizedBox(width: 10),
                                          Container(
                                            width: 75,
                                            child: Text(
                                              "Total Pendapatan",
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'CircularStd-Medium'),
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            child: BlocBuilder<ReportBloc,
                                                ReportState>(
                                              builder: (context, state) {
                                                if (state is ReportLoaded) {
                                                  return Text(
                                                    "Rp " +
                                                        FlutterMoneyFormatter(
                                                                amount: double
                                                                    .parse(state
                                                                        .totalIncome))
                                                            .output
                                                            .withoutFractionDigits,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        fontFamily:
                                                            'CircularStd-Bold'),
                                                  );
                                                }
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(height: 0.1, color: Colors.black12),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              child: Icon(Icons.attach_money,
                                                  size: 20)),
                                          SizedBox(width: 10),
                                          Container(
                                            width: 75,
                                            child: Text(
                                              "Total Menu Terjual",
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'CircularStd-Medium'),
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                BlocBuilder<ReportBloc,
                                                    ReportState>(
                                                  builder: (context, state) {
                                                    if (state is ReportLoaded) {
                                                      return Text(
                                                        state.totalSalesMenu,
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18.0,
                                                            fontFamily:
                                                                'CircularStd-Bold'),
                                                      );
                                                    }
                                                    return CircularProgressIndicator();
                                                  },
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  "Porsi",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0,
                                                      fontFamily:
                                                          'CircularStd-Bold'),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(height: 0.1, color: Colors.black12),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              child: Icon(Icons.attach_money,
                                                  size: 20)),
                                          SizedBox(width: 10),
                                          Container(
                                            width: 75,
                                            child: Text(
                                              "Total Keuntungan",
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'CircularStd-Medium'),
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            child: BlocBuilder<ReportBloc,
                                                ReportState>(
                                              builder: (context, state) {
                                                if (state is ReportLoaded) {
                                                  return Text(
                                                    "Rp " +
                                                        FlutterMoneyFormatter(
                                                                amount: double
                                                                    .parse(state
                                                                        .totalProfit))
                                                            .output
                                                            .withoutFractionDigits,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        fontFamily:
                                                            'CircularStd-Bold'),
                                                  );
                                                }
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            Card(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              elevation: 10,
              shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Menu Makanan Terlaris",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                            fontFamily: 'CircularStd-Bold'),
                      ),
                      BlocBuilder<ReportBloc, ReportState>(
                        builder: (context, state) {
                          if (state is ReportLoaded) {
                            return buildListMenuSales(state.best5foodsales);
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            padding: EdgeInsets.all(10),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReportDetailPage(
                                        startDate: _startDate,
                                        endDate: _endDate),
                                  ));
                            },
                            child: Text(
                              "> Lihat Semua Menu",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 12.0,
                                  fontFamily: 'CircularStd-Bold'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              elevation: 10,
              shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Menu Minuman Terlaris",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                            fontFamily: 'CircularStd-Bold'),
                      ),
                      BlocBuilder<ReportBloc, ReportState>(
                        builder: (context, state) {
                          if (state is ReportLoaded) {
                            return buildListMenuSales(state.best5drinksales);
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            padding: EdgeInsets.all(10),
                            onPressed: null,
                            child: Text(
                              "> Lihat Semua Menu",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 12.0,
                                  fontFamily: 'CircularStd-Bold'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              elevation: 10,
              shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Menu Makanan Kurang Laris",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                            fontFamily: 'CircularStd-Bold'),
                      ),
                      BlocBuilder<ReportBloc, ReportState>(
                        builder: (context, state) {
                          if (state is ReportLoaded) {
                            return buildListMenuSales(state.lowest5foodsales);
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            padding: EdgeInsets.all(10),
                            onPressed: null,
                            child: Text(
                              "> Lihat Semua Menu",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 12.0,
                                  fontFamily: 'CircularStd-Bold'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              elevation: 10,
              shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Menu Minuman Kurang Laris",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                            fontFamily: 'CircularStd-Bold'),
                      ),
                      BlocBuilder<ReportBloc, ReportState>(
                        builder: (context, state) {
                          if (state is ReportLoaded) {
                            return buildListMenuSales(state.lowest5drinksales);
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            padding: EdgeInsets.all(10),
                            onPressed: null,
                            child: Text(
                              "> Lihat Semua Menu",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 12.0,
                                  fontFamily: 'CircularStd-Bold'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(20),
              elevation: 10,
              shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Grafik Penjualan Menu",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                            fontFamily: 'CircularStd-Bold'),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            height: MediaQuery.of(context).size.height / 3,
                            child: BlocBuilder<ReportBloc,ReportState>(
                              builder: (context,state){
                                if(state is ReportLoaded){
                                  if(state.weeklyReportSales != null){
                                    return TimeSeriesRangeAnnotationChart(state.weeklyReportSales);
                                  }
                                    return Center(child: Text("Tidak ada penjualan"));
                                }
                                return Center();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(20),
              elevation: 10,
              shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Grafik Pendapatan Penjualan",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                            fontFamily: 'CircularStd-Bold'),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            height: MediaQuery.of(context).size.height / 3,
                            child: BlocBuilder<ReportBloc,ReportState>(
                              builder: (context,state){
                                if(state is ReportLoaded){
                                  if(state.weeklyReportSales != null){
                                    return TimeSeriesRangeAnnotationChart(state.weeklyReportIncome);
                                  }
                                  return Center(child: Text("Tidak ada penjualan"));
                                }
                                return Center();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(20),
              elevation: 10,
              shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Grafik Keuntungan Penjualan",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                            fontFamily: 'CircularStd-Bold'),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            height: MediaQuery.of(context).size.height / 3,
                            child: BlocBuilder<ReportBloc,ReportState>(
                              builder: (context,state){
                                if(state is ReportLoaded){
                                  if(state.weeklyReportSales != null){
                                    return TimeSeriesRangeAnnotationChart(state.weeklyReportProfit);
                                  }
                                  return Center(child: Text("Tidak ada penjualan"));
                                }
                                return Center();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ]))
        ],
      ),
    );
  }

  Widget buildListMenuSales(ListOrderItem listSales) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        physics: new ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: listSales.listOrderItem.length,
        itemBuilder: (_, index) {
          OrderItem item = listSales.listOrderItem[index];
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        item.name_menu,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontFamily: 'CircularStd-Medium'),
                      ),
                    ),
                    Container(
                      child: Text(
                        item.quantity.toString() + " porsi",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontFamily: 'CircularStd-Bold'),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 0.1, color: Colors.black12)
            ],
          );
        });
  }
}

class SalesData {
  final String date;
  final int sales;

  SalesData(this.date, this.sales);
}

class TimeSeriesRangeAnnotationChart extends StatelessWidget {
  final List<Report> listReport;

  TimeSeriesRangeAnnotationChart(
      this.listReport); //  final List<charts.Series> seriesList;

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(_createSampleData(),
        animate: true,
        behaviors: [
          new charts.RangeAnnotation([
            new charts.RangeAnnotationSegment(
                listReport.first.startDate,
                listReport.last.startDate,
                charts.RangeAnnotationAxisType.domain),
          ]),
        ]);
  }

  List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    List<TimeSeriesSales> data = [];
    listReport.forEach((element) {
      if(element.quantity != null){
        data.add(new TimeSeriesSales(element.startDate, element.quantity));
      } else if(element.income != null){
        data.add(new TimeSeriesSales(element.startDate, element.income));
      } else{
        data.add(new TimeSeriesSales(element.startDate, element.profit));
      }
    });

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
