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

class PredictionDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PredictionBloc>(
      create: (context) => PredictionBloc()
        ..add(GetDetailPrediction()),
      child: PredictionDetail(),
    );
  }
}

class PredictionDetail extends StatefulWidget {
  _PredictionDetailState createState() => _PredictionDetailState();
}

class _PredictionDetailState extends State<PredictionDetail> {
  PredictionBloc _predictionBloc;

  @override
  void initState() {
    _predictionBloc = BlocProvider.of<PredictionBloc>(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Detail Prediksi Penjualan",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'CircularStd-Bold'),
            ),
            bottom: PreferredSize(
              child: Column(
                children: <Widget>[
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
              preferredSize: Size(0, 50),
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
          body: BlocBuilder<PredictionBloc, PredictionState>(
            builder: (context, state) {
              if (state is PredictionDetailLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is PredictionDetailLoaded) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      ListView.builder(
                          itemCount: state.listPrediction.length,
                          itemBuilder: (_, index) {
                            Prediction prediction = state.listPrediction[index];
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
                                          prediction.name_menu,
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
                                                  amount: double.parse(prediction.income.toString()))
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
                                          Text(prediction.wma.toString() + " porsi",
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
                                                  amount: double.parse(prediction.profit.toString()))
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
