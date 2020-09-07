import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/ManageOrder/receipt_page.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PaymentPage extends StatelessWidget {
  final Order order;

  PaymentPage({this.order});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PaymentBloc>(
          create: (context) => PaymentBloc()..add(fetchOrder(order: order))),
      BlocProvider<CheckoutOrderBloc>(
        create: (context) => CheckoutOrderBloc()..add(getOrder(order: order))
      )
    ], child: PaymentOrder());
  }
}

class PaymentOrder extends StatefulWidget {
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<PaymentOrder>
    with SingleTickerProviderStateMixin {
  String nominalBayar = "0";
  String number = "";

  PaymentBloc _paymentBloc;

  @override
  void initState() {
    super.initState();
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
  }

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        number = " ";
        nominalBayar = "0";
      } else if (buttonText == "0" || buttonText == "000") {
        if (nominalBayar == "0") {
          nominalBayar = "0";
        } else {
          number = number + buttonText;
          nominalBayar = number;
        }
      } else {
        number = number + buttonText;
        nominalBayar = number;
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
        child: MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 6),
            onPressed: () => buttonPressed(buttonText),
            child: Text(buttonText,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                    fontFamily: 'CircularStd-Bold'))));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
      if(state is PaymentSuccess){
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReceiptPage(sales: state.sales, payment: state.payment, order: state.order, listOrderItem: state.listOrderItem,)));
        });
      }
      return ModalProgressHUD(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Pembayaran",
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
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          width: MediaQuery.of(context).size.width,
                          height: 110,
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
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: BlocBuilder<CheckoutOrderBloc,CheckoutOrderState>(
                                builder: (context, state) {
                              if (state is CheckoutOrderLoaded) {
                                return Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Center(
                                              child: Text(
                                                  "#" +
                                                      state.order.id_order
                                                          .substring(0, 6) +
                                                      state.order.id_order
                                                          .substring(15, 18),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      fontFamily:
                                                      'CircularStd-Bold'))),
                                        ),
                                        SizedBox(width: 20),
                                        Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height /
                                              45,
                                          child: Center(
                                              child: Text(
                                                  DateFormat('EEE, d MMMM '
                                                      'yyyy')
                                                      .format(state.order.date),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13.0,
                                                      fontFamily:
                                                      'CircularStd-Book'))),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height:
                                      MediaQuery.of(context).size.height /
                                          45,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                          child: Text("Total Bayar",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                  'CircularStd-Bold'))),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Text(
                                            "Rp " +
                                                state.order.total_price
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 30.0,
                                                fontFamily:
                                                'CircularStd-Bold')),
                                      ),
                                    )
                                  ],
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
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
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 20,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text("Nominal Bayar",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontFamily: 'CircularStd-Bold'))),
                                ),
                                Container(
                                    height:
                                        MediaQuery.of(context).size.height / 19,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Rp ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 30.0,
                                                  fontFamily:
                                                      'CircularStd-Bold')),
                                          Text("$nominalBayar",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 30.0,
                                                  fontFamily:
                                                      'CircularStd-Bold')),
                                        ])),
                              ],
                            ),
                          ),
                        ),
                      ],
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
              preferredSize: Size(0, 310),
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
          body: BlocListener<PaymentBloc, PaymentState>(
            listener: (context, state) {
              if (state is PaymentFailure) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.3,
                    child: Column(children: <Widget>[
                      SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buildButton("7"),
                            buildButton("8"),
                            buildButton("9"),
                          ]),
                      SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buildButton("4"),
                            buildButton("5"),
                            buildButton("6"),
                          ]),
                      SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buildButton("1"),
                            buildButton("2"),
                            buildButton("3"),
                          ]),
                      SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buildButton("0"),
                            buildButton("000"),
                            buildButton("C"),
                          ]),
                    ]),
                  ),
                  BlocBuilder<CheckoutOrderBloc,CheckoutOrderState>(
                    builder: (context,state){
                      if(state is CheckoutOrderLoaded){
                        return payment(state.order, int.parse(this.nominalBayar));
                      } return Center(child: Text(""));
                    }
                  ),
                ],
              )
            ),
          ),
        ),
        inAsyncCall: state is PaymentInProcess,
        opacity: 0.7,
        color: Color.fromRGBO(54, 58, 155, 1),
      );
    });
  }

  Widget payment(Order order, int cash) {
    return Positioned(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
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
                          "Buat Pembayaran",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'CircularStd-Bold'),
                        )
                      ]),
                  onPressed: () async {
                    await _paymentBloc
                        .add(createPayment(order: order, cash: cash));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
