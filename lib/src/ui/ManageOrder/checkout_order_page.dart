import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/ManageOrder/payment_page.dart';
import 'package:apos/src/ui/ManageOrder/receipt_page.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CheckoutOrderPage extends StatelessWidget {
  final id_order;

  CheckoutOrderPage({this.id_order});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckoutOrderBloc>(
      create: (context) =>
          CheckoutOrderBloc()..add(fetchOrderDetail(id_order: id_order)),
      child: CheckoutOrder(),
    );
  }
}

class CheckoutOrder extends StatefulWidget {
  _CheckoutOrderState createState() => _CheckoutOrderState();
}

class _CheckoutOrderState extends State<CheckoutOrder> {
  CheckoutOrderBloc _checkoutBloc;

  @override
  void initState() {
    super.initState();
    _checkoutBloc = BlocProvider.of<CheckoutOrderBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Checkout Pesanan",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'CircularStd-Bold'),
            ),
            bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),
                  Container(
                    // margin: EdgeInsets.symmetric(vertical:10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: BlocBuilder<CheckoutOrderBloc, CheckoutOrderState>(
                          builder: (context, state) {
                        if (state is CheckoutOrderLoaded) {
                          return Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                    child: Text(
                                        "#" +
                                            state.order.id_order
                                                .substring(0, 6) +
                                            state.order.id_order
                                                .substring(15, 18),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30.0,
                                            fontFamily: 'CircularStd-Bold'))),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 45,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                    child: Text(
                                        DateFormat('EEE, d MMMM '
                                                'yyyy')
                                            .format(state.order.date),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontFamily: 'CircularStd-Book'))),
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
                                              .withoutFractionDigits,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25.0,
                                          fontFamily: 'CircularStd-Bold')),
                                ),
                              )
                            ],
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                    ),
                  )
                ],
              ),
              preferredSize: Size(0, 135),
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
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<CheckoutOrderBloc, CheckoutOrderState>(
                builder: (context, state) {
              if (state is CheckoutOrderLoaded) {
                print(state.listOrderItem.listOrderItem.length);
                return Stack(children: <Widget>[
                  buildListOrderItem(context, state.listOrderItem),
                  processPayment(state.order)
                ]);
              }
              return Center(child: CircularProgressIndicator());
            }),
          ),
        ),
      ]),
    );
  }

  Widget processPayment(Order order) {
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
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                // margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                          FaIcon(
                            FontAwesomeIcons.plus,
                            size: 17,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Buat Pembayaran",
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
                            builder: (context) => PaymentPage(order: order),
                          )).then((value) {
                        if (value) {
                          Navigator.pop(context,true);
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildListOrderItem(BuildContext context, ListOrderItem listOrderItem) {
  return ListView.builder(
      itemCount: listOrderItem.listOrderItem.length,
      itemBuilder: (_, index) {
        OrderItem orderItem = listOrderItem.listOrderItem[index];
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
                          Text(orderItem.name_menu.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontFamily: 'CircularStd-Bold')),
                          Text(orderItem.quantity.toString() + " pcs",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'CircularStd-Book')),
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
                              Text("Rp " + FlutterMoneyFormatter(amount: double.parse(orderItem.subtotal_price.toString())).output.withoutFractionDigits,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'CircularStd-Bold'))
                            ],
                          )))
                ]));
      });
}
