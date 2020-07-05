import 'package:apos/src/ui/RiwayatTransaksi/riwayat_detail.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class PrediksiPenjualan extends StatefulWidget {
  _PrediksiPenjualanState createState() => _PrediksiPenjualanState();
}

class _PrediksiPenjualanState extends State<PrediksiPenjualan>
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
              "Prediksi Penjualan",
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
                    child: Text(
                        "Prediksi penjualan ini hanya berlaku untuk memprediksi penjualan menu untuk 1 pekan kedepan dengan persyaratan terdapat data penjualan 3 pekan sebelumnya.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'CircularStd-Bold')),
                  ),
                  SizedBox(height: 10),
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 30),
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
                                "Prediksi Penjualan",
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
              preferredSize: Size(0, 280),
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
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.8,
            child: Stack(
                children: <Widget>[buildListPerhitunganPenjualan(context)]),
          ),
        ),
      ]),
    );
  }
}

Widget buildListPerhitunganPenjualan(BuildContext context) {
  return ListView.builder(
      itemCount: 10,
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
                  Container(
                    width: 55,
                    height: 55,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(234, 234, 234, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Nama Menu #$index",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontFamily: 'CircularStd-Bold')),
                          Text("Rp 40.000",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'CircularStd-Book'))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("Prediksi Terjual ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontFamily: 'CircularStd-Book')),
                              Text("20 pcs",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'CircularStd-Bold')),
                            ],
                          )))
                ]));
      });
}

class Outlet {
  String name;
  Outlet(this.name);
}
