import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/History/history_detail.dart';
import 'package:apos/src/ui/Prediction/prediction_detail.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apos/src/bloc/bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PredictionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PredictionBloc(),
      child: PredictionSales(),
    );
  }
}

class PredictionSales extends StatefulWidget {
  _PredictionSalesState createState() => _PredictionSalesState();
}

class _PredictionSalesState extends State<PredictionSales> {
  PredictionBloc _predictionBloc;

  //   OutletBloc _outletBloc;

  @override
  void initState() {
    _predictionBloc = BlocProvider.of<PredictionBloc>(context);
    _predictionBloc.add(GetPredictionSummary());
    super.initState();
  }

  @override
  void dispose() {
    _predictionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              pinned: true,
              expandedHeight: 350.0,
              backgroundColor: Color.fromRGBO(252, 195, 108, 1),
              title: Text(
                "Prediksi Penjualan",
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
                    SafeArea(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(30, 50, 30, 30),
                        height: 100,
                        child: Card(
                          color: Color.fromRGBO(54, 58, 155, 1),
                          elevation: 10,
                          shadowColor: Color.fromRGBO(0, 0, 0, 0.2),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.info_outline,
                                    size: 30, color: Colors.white),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      "Data prediksi menu yang ditampilkan berdasarkan prediksi menu yang memiliki presentasi akurasi keberhasilan diatas 80%",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontFamily: 'CircularStd-Bold'),
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
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
                                              "Prediksi Pendapatan",
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
                                            child: BlocBuilder<PredictionBloc,
                                                PredictionState>(
                                              builder: (context, state) {
                                                if (state is PredictionLoaded) {
                                                  return Text(
                                                    "Rp " +
                                                        FlutterMoneyFormatter(
                                                                amount: double
                                                                    .parse(state
                                                                        .totalIncomePrediction))
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
                                            width: 80,
                                            child: Text(
                                              "Prediksi Menu Terjual",
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
                                            width: 195,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                BlocBuilder<PredictionBloc,
                                                    PredictionState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is PredictionLoaded) {
                                                      return Text(
                                                        state
                                                            .totalSalesPrediction
                                                            .toString(),
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
                                              "Prediksi Keuntungan",
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
                                            child: BlocBuilder<PredictionBloc,
                                                PredictionState>(
                                              builder: (context, state) {
                                                if (state is PredictionLoaded) {
                                                  return Text(
                                                    "Rp " +
                                                        FlutterMoneyFormatter(
                                                                amount: double
                                                                    .parse(state
                                                                        .totalProfitPrediction))
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
                        "Prediksi Penjualan Menu",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                            fontFamily: 'CircularStd-Bold'),
                      ),
                      BlocBuilder<PredictionBloc, PredictionState>(
                        builder: (context, state) {
                          if (state is PredictionLoaded) {
                            return buildListPredictionSales(
                                state.listPrediction);
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
                                    builder: (context) =>
                                        PredictionDetailPage(),
                                  ));
                            },
                            child: Text(
                              "> Lihat Seluruh Prediksi Penjualan",
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
          ]))
        ],
      ),
    );
  }

  Widget buildListPredictionSales(List<Prediction> listPrediction) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        physics: new ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (_, index) {
          Prediction item = listPrediction[index];
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
                        item.wma.toString() + " porsi",
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
  final int year;
  final int sales;

  SalesData(this.year, this.sales);
}
