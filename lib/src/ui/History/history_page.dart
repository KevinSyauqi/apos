import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/bloc/history/history_bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/History/history_detail.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc(),
      child: TransactionHistory(),
    );
  }
}

class TransactionHistory extends StatefulWidget {
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 1));
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  String selectedStartDate = "Periode Awal";
  String selectedEndDate = "Periode Akhir";
  HistoryBloc _historyBloc;

  @override
  void initState() {
    _historyBloc = BlocProvider.of<HistoryBloc>(context);
    _historyBloc.add(FetchSales());
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
  void dispose() {
    super.dispose();
    _historyBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Riwayat Transaksi",
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
          drawer: AppDrawer(),
          body: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is HistoryLoaded) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      ListView.builder(
                          itemCount: state.listSales.length,
                          itemBuilder: (_, index) {
                            Sales sale = state.listSales[index];
                            return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:
                                              Color.fromRGBO(224, 224, 224, 1),
                                          width: 1.0)),
                                  color: Color.fromRGBO(250, 250, 250, 1),
                                ),
                                width: double.infinity,
                                height: 80,
                                margin: EdgeInsets.symmetric(horizontal: 25),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HistoryDetailPage(sale.id_sale),
                                                  ));
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                    "No #" +
                                                        sale.id_sale
                                                            .substring(0, 6) +
                                                        sale.id_sale
                                                            .substring(12,17),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        fontFamily:
                                                            'CircularStd-Bold')),
                                                Text(
                                                    DateFormat('EEE, d MMMM '
                                                            'yyyy')
                                                        .format(
                                                            sale.date_created),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.0,
                                                        fontFamily:
                                                            'CircularStd-Book')),
                                                state.customers_name[index] != '' ?
                                                Text(
                                                    "Pelanggan : " + state.customers_name[index],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.0,
                                                        fontFamily:
                                                            'CircularStd-Bold')) : Text("")
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            54, 58, 155, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13)),
                                                    child: IconButton(
                                                      icon: Icon(Icons.arrow_forward_ios),
                                                      iconSize: 17,
                                                      color: Colors.white,
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  HistoryDetailPage(sale.id_sale),
                                                            ));
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )))
                                    ]));
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