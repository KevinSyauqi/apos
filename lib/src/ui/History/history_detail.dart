import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/History//history_page.dart';
import 'package:apos/src/ui/ManageOrder//checkout_order_page.dart';
import 'package:apos/src/ui/ManageOrder//manage_order_page.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class HistoryDetailPage extends StatelessWidget {
  final String id_sale;

  HistoryDetailPage(this.id_sale);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HistoryBloc>(
      create: (context) => HistoryBloc()..add(GetDetailSales(id_sale: id_sale)),
      child: HistoryDetail(),
    );
  }
}

class HistoryDetail extends StatefulWidget {
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail>
    with SingleTickerProviderStateMixin {
  HistoryBloc _historyBloc;

  @override
  void initState() {
    super.initState();
    _historyBloc = BlocProvider.of<HistoryBloc>(context);
  }

  @override
  void dispose() {
    _historyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Detail Transaksi",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'CircularStd-Bold'),
            ),
            bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Container(
                    // height: 50,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: BlocBuilder<HistoryBloc, HistoryState>(
                        builder: (context, state) {
                          if (state is DetailHistoryLoaded) {
                            return Column(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text("Nomor Transaksi :",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontFamily: 'CircularStd-Bold'))),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text(state.sales.id_sale,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontFamily: 'CircularStd-Book'))),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 45,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text("Kamis, 20 Juli 2020",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontFamily: 'CircularStd-Book'))),
                                ),
                                
                                SizedBox(height: 10),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text("Total Pesanan :",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontFamily: 'CircularStd-Bold'))),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                        "Rp " +
                                            FlutterMoneyFormatter(
                                                    amount: double.parse(state
                                                        .order.total_price
                                                        .toString()))
                                                .output
                                                .withoutFractionDigits
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'CircularStd-Bold')),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text("Total Bayar :",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontFamily: 'CircularStd-Bold'))),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                        "Rp " +
                                            FlutterMoneyFormatter(
                                                    amount: double.parse(state
                                                        .payment.cash
                                                        .toString()))
                                                .output
                                                .withoutFractionDigits,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'CircularStd-Bold')),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text("Kembalian :",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontFamily: 'CircularStd-Bold'))),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                        "Rp " +
                                            FlutterMoneyFormatter(
                                                    amount: double.parse(state
                                                        .payment.change_amount
                                                        .toString()))
                                                .output
                                                .withoutFractionDigits,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'CircularStd-Bold')),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Divider(height: 0.1, color: Colors.black12),
                              ],
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    ),
                  )
                ],
              ),
              preferredSize: Size(0, 240),
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
          // drawer: AppDrawer(),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.8,
            child: Stack(children: <Widget>[
              BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, state) {
                  if (state is DetailHistoryLoaded) {
                    return buildListMenuTransaction(state.listOrderItem);
                  }
                  return CircularProgressIndicator();
                },
              )
            ]),
          ),
        ),
      ]),
    );
  }
}

Widget buildListMenuTransaction(List<OrderItem> listOrderItem) {
  return ListView.builder(
      itemCount: listOrderItem.length,
      itemBuilder: (_, index) {
        OrderItem item = listOrderItem[index];
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
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              Container(
                width: 55,
                height: 55,
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://apos-server-kota202.et.r.appspot.com/manageMenu/photo?id_menu=" + item.id_menu)),
                    color: Color.fromRGBO(234, 234, 234, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                width: 190,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(item.name_menu,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontFamily: 'CircularStd-Bold')),
                    Text(
                        "Rp " +
                            FlutterMoneyFormatter(
                                    amount: double.parse(
                                        (item.subtotal_price / item.quantity)
                                            .toString()))
                                .output
                                .withoutFractionDigits +
                            " x " +
                            (item.quantity).toString() +
                            " pcs",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: 'CircularStd-Book'))
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              "Rp " +
                                  FlutterMoneyFormatter(
                                          amount: double.parse(
                                              item.subtotal_price.toString()))
                                      .output
                                      .withoutFractionDigits,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontFamily: 'CircularStd-Bold'))
                        ],
                      )))
            ]));
      });
}
