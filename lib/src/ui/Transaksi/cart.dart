import 'package:apos/src/ui/Transaksi/checkout.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';

class KeranjangMenu extends StatefulWidget {
  _KeranjangMenuState createState() => _KeranjangMenuState();
}

class _KeranjangMenuState extends State<KeranjangMenu>
    with SingleTickerProviderStateMixin {
  String nominalBayar = "0";
  String number = "";

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
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Keranjang",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'CircularStd-Bold'),
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => TransaksiKustom(),
                  //     ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  decoration: BoxDecoration(
                    // color: Color.fromRGBO(0, 0, 0, 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.dialpad, color: Colors.white, size: 18),
                      SizedBox(width: 3),
                      Text(
                        "Bayar Nanti",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'CircularStd-Bold'),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
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
                            padding: EdgeInsets.all(15),
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
                                Container(
                                    height:
                                        MediaQuery.of(context).size.height / 19,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                        child: Text("Rp 10.000",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 42.0,
                                                fontFamily:
                                                    'CircularStd-Bold')))),
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
              preferredSize: Size(0, 180),
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
                buildListKeranjangMenu(context),
                checkout(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildListKeranjangMenu(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
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
                            Text("Rp 2.500 x 2",
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
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Rp 5.000",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontFamily: 'CircularStd-Bold')),
                                SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      padding: EdgeInsets.only(bottom: 4),
                                      width: 32,
                                      height: 32,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(54, 58, 155, 1),
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Text("x",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontFamily: 'CircularStd-Bold'))),
                                ),
                              ],
                            ))),
                  ]));
        });
  }

  Widget checkout() {
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
                          "Checkout",
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
                          builder: (context) => CheckoutMenu(),
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
