import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/ui/Transaksi/struk.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckoutBloc>(
      create: (context) => CheckoutBloc(),
      child: CheckoutMenu(),
    );
  }
}

class CheckoutMenu extends StatefulWidget {
  _CheckoutMenuState createState() => _CheckoutMenuState();
}

class _CheckoutMenuState extends State<CheckoutMenu>
    with SingleTickerProviderStateMixin {
  String nominalBayar = "0";
  String number = "";
  String totalBayar;

  CheckoutBloc _checkoutBloc;

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

  @override
  void initState() {
    super.initState();
    _checkoutBloc = BlocProvider.of<CheckoutBloc>(context);
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
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Checkout",
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
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 35,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text("Total Pembayaran",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontFamily: 'CircularStd-Bold'))),
                                ),
                                BlocBuilder<CheckoutBloc, CheckoutState>(
                                  builder: (context, state) {
                                    if (state is CheckoutLoaded) {
                                      setState(() {
                                        totalBayar =
                                            state.totalPrice.toString();
                                      });
                                    } else totalBayar = "0";
                                    return Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                19,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Center(
                                            child: Text("Rp "+totalBayar,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 39.0,
                                                    fontFamily:
                                                        'CircularStd-Bold'))));
                                  },
                                ),
                              ],
                            ),
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
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 36,
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
                                                  fontSize: 42.0,
                                                  fontFamily:
                                                      'CircularStd-Bold')),
                                          Text("$nominalBayar",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 42.0,
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
              preferredSize: Size(0, 290),
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.3,
                  child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          hintText: "Nama Pelanggan (Opsional)",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontFamily: 'CircularStd-Book'),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildButton("7"),
                          buildButton("8"),
                          buildButton("9"),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildButton("4"),
                          buildButton("5"),
                          buildButton("6"),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildButton("1"),
                          buildButton("2"),
                          buildButton("3"),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildButton("0"),
                          buildButton("000"),
                          buildButton("C"),
                        ]),
                  ]),
                ),
                payment(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget payment() {
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
                          "Pembayaran",
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
                          builder: (context) => StrukPembayaran(),
                        ));
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
