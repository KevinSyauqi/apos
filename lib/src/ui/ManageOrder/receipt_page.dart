import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class ReceiptPage extends StatelessWidget {
  Sales sales;
  Order order;
  Payment payment;
  ListOrderItem listOrderItem;

  ReceiptPage({this.sales, this.order, this.payment, this.listOrderItem});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReceiptBloc>(
      create: (context) => ReceiptBloc()
        ..add(getReceipt(
            order: order,
            sales: sales,
            payment: payment,
            listOrderItem: listOrderItem)),
      child: ReceiptSales(),
    );
  }
}

class ReceiptSales extends StatefulWidget {
  _ReceiptSalesState createState() => _ReceiptSalesState();
}

class _ReceiptSalesState extends State<ReceiptSales> {
  ReceiptBloc _receiptBloc;

  @override
  void initState() {
    super.initState();
    _receiptBloc = BlocProvider.of<ReceiptBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: Stack(children: <Widget>[
          Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Struk Pembayaran",
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
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: BlocBuilder<ReceiptBloc, ReceiptState>(
                        builder: (context, state) {
                          if (state is ReceiptLoaded) {
                            return Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: <Widget>[
                                  Text("Kamis, 20 Juli 2020",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontFamily: 'CircularStd-Book')),
                                  Text(
                                      "Transaksi No #" +
                                          state.order.id_order.substring(0, 6) +
                                          state.order.id_order.substring(15, 18),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontFamily: 'CircularStd-Bold')),
                                  Text("Total Pembayaran",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontFamily: 'CircularStd-Book')),
                                  Text(
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
                                  Text("Nominal Pembayaran",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontFamily: 'CircularStd-Book')),
                                  Text(
                                      "Rp " +
                                          FlutterMoneyFormatter(
                                                  amount: double.parse(state
                                                      .payment.cash
                                                      .toString()))
                                              .output
                                              .withoutFractionDigits,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25.0,
                                          fontFamily: 'CircularStd-Bold')),
                                  Text("Kembalian",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontFamily: 'CircularStd-Book')),
                                  Text(
                                      "Rp " +
                                          FlutterMoneyFormatter(
                                                  amount: double.parse(state
                                                      .payment.change_amount
                                                      .toString()))
                                              .output
                                              .withoutFractionDigits,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25.0,
                                          fontFamily: 'CircularStd-Bold')),
                                ],
                              ),
                            );
                          }
                          return Text("");
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25),
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
                preferredSize: Size(0, 300),
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
              child: Stack(children: <Widget>[
                BlocBuilder<ReceiptBloc, ReceiptState>(
                  builder: (context, state) {
                    if (state is ReceiptLoaded) {
                      return buildListMenuTransaction(
                          context, state.listOrderItem);
                    }
                    return Text("");
                  },
                ),
                bottomButton()
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _showAlertShare() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text("Masukkan email pelanggan",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'CircularStd-Bold')),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                height: 50,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: "Email Pelanggan",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        fontFamily: 'CircularStd-Book'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(children: <Widget>[
                  RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 50),
                      color: Color.fromRGBO(54, 58, 155, 1),
                      elevation: 5,
                      onPressed: () => Navigator.pop(context),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0))),
                      child: Text("Kirim",
                          style: TextStyle(
                            color: Colors.white,
                          ))),
                  SizedBox(width: 10),
                  RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 50),
                      color: Color.fromRGBO(234, 234, 234, 1),
                      elevation: 5,
                      onPressed: () => Navigator.pop(context),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0))),
                      child: Text("Batal",
                          style: TextStyle(
                            color: Colors.black,
                          ))),
                ]),
              )
            ],
          );
        });
  }

  Widget buildListMenuTransaction(
      BuildContext context, ListOrderItem listOrderItem) {
    return Container(
      margin: EdgeInsets.only(bottom: 90),
      child: ListView.builder(
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
                              Text(orderItem.name_menu,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'CircularStd-Bold')),
                              Text(
                                  "Rp " +
                                      FlutterMoneyFormatter(
                                              amount: double.parse(
                                                  (orderItem.subtotal_price /
                                                          orderItem.quantity)
                                                      .toInt()
                                                      .toString()))
                                          .output
                                          .withoutFractionDigits +
                                      " x " +
                                      orderItem.quantity.toString(),
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
                              child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                              "Rp " +
                                  FlutterMoneyFormatter(
                                          amount: double.parse(orderItem
                                              .subtotal_price
                                              .toString()))
                                      .output
                                      .withoutFractionDigits,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontFamily: 'CircularStd-Bold')),
                        ],
                      ))),
                    ]));
          }),
    );
  }

  Widget bottomButton() {
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
                width: MediaQuery.of(context).size.width / 1.4,
                margin: EdgeInsets.fromLTRB(20, 20, 10, 20),
                alignment: Alignment.center,
                child: ButtonTheme(
                  height: 50,
                  padding:
                      EdgeInsets.only(left: 35, right: 35, bottom: 15, top: 15),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Color.fromRGBO(54, 58, 155, 1),
                    child: Text(
                      "Kembali ke Daftar Pesanan",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'CircularStd-Bold'),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 8,
                height: 50,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(54, 58, 155, 1),
                    borderRadius: BorderRadius.circular(19)),
                child: IconButton(
                  icon: Icon(Icons.share),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {
                    _showAlertShare();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
