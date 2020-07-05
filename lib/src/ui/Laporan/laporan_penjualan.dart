import 'package:apos/src/bloc/report/report_bloc.dart';
import 'package:apos/src/ui/Laporan/laporan_perhitungan_penjualan.dart';
import 'package:apos/src/ui/Laporan/laporan_prediksi.dart';
import 'package:apos/src/ui/RiwayatTransaksi/riwayat_detail.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;


class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportBloc(),
      child: LaporanPenjualan(),
    );
  }
}

class LaporanPenjualan extends StatefulWidget {
  _LaporanPenjualanState createState() => _LaporanPenjualanState();
}

class _LaporanPenjualanState extends State<LaporanPenjualan>
    with SingleTickerProviderStateMixin {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 1));
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  String selectedStartDate = "Periode Awal";
  String selectedEndDate = "Periode Akhir";

  Outlet selectedOutlet;
  List<Outlet> outlet = [
    Outlet("Kopo Sayati"),
    Outlet("Sarijadi"),
    Outlet("Kebon Jati")
  ];

  List<DropdownMenuItem> generateItems(List<Outlet> category) {
    List<DropdownMenuItem> items = [];
    for (var item in outlet) {
      items.add(DropdownMenuItem(
        child: Text(item.name),
        value: item,
      ));
    }
    return items;
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
        selectedStartDate = DateFormat("dd/MM/yyyy").format(_startDate);
        selectedEndDate = DateFormat("dd/MM/yyyy").format(_endDate);
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
              "Laporan Penjualan",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'CircularStd-Bold'),
            ),
            bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Icon(Icons.store)),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                            width: MediaQuery.of(context).size.width / 1.4,
                            height: 55,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration.collapsed(
                                hintText: 'Pilih Outlet',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(179, 179, 183, 1),
                                    fontSize: 13.0,
                                    fontFamily: 'CircularStd-Book'),
                              ),
                              isExpanded: true,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                  fontFamily: 'CircularStd-Book'),
                              value: selectedOutlet,
                              items: generateItems(outlet),
                              onChanged: (item) {
                                setState(() {
                                  selectedOutlet = item;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        selectedStartDate,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            fontFamily: 'CircularStd-Book'),
                                      ),
                                      Text(
                                        " - ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            fontFamily: 'CircularStd-Book'),
                                      ),
                                      Text(
                                        selectedEndDate,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            fontFamily: 'CircularStd-Book'),
                                      ),
                                    ],
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
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(55),
                            topRight: Radius.circular(55))),
                  )
                ],
              ),
              preferredSize: Size(0, 200),
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
                Column(
                  children: <Widget>[
                    Text(
                      "Grafik Penjualan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: 'CircularStd-Bold'),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      height: MediaQuery.of(context).size.height / 3,
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          series: <LineSeries<SalesData, String>>[
                            LineSeries<SalesData, String>(
                                // Bind data source
                                dataSource: <SalesData>[
                                  SalesData('Jan', 35),
                                  SalesData('Feb', 28),
                                  SalesData('Mar', 34),
                                  SalesData('Apr', 32),
                                  SalesData('May', 40),
                                  SalesData('Jun', 35),
                                  SalesData('Jul', 28),
                                  SalesData('Ags', 34),
                                  SalesData('Sep', 32),
                                  SalesData('Okt', 40)
                                ],
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales)
                          ]),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  "Perhitungan Laba Rugi",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontFamily: 'CircularStd-Bold'),
                                )
                              ]),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  "Perhitungan Penjualan Menu",
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
                                  builder: (context) => PerhitunganPenjualan(),
                                ));
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  "Prediksi Penjualan Menu",
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
                                  builder: (context) => PrediksiPenjualan(),
                                ));
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

Widget buildListHistory(BuildContext context) {
  return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, index) {
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
                  Expanded(
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailRiwayatTransaksi(),
                              ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Transaksi No #$index",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontFamily: 'CircularStd-Bold')),
                            Text("Kamis, 20 Juli 2020",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: 'CircularStd-Book')),
                            Text("Rp 100.000",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: 'CircularStd-Bold')),
                          ],
                        ),
                      ),
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
                                height: 32,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(54, 58, 155, 1),
                                    borderRadius: BorderRadius.circular(13)),
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Text("Bayar",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontFamily: 'CircularStd-Bold')),
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
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          )))
                ]));
      });
}

class Outlet {
  String name;
  Outlet(this.name);
}
