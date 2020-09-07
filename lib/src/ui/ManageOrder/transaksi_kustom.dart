import 'package:apos/src/ui/History/riwayat_transaksi.dart';
import 'package:apos/src/ui/ManageOrder/checkout_order_page.dart';
import 'package:apos/src/ui/ManageOrder/manage_order_page.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';

class TransaksiKustom extends StatefulWidget {
  _TransaksiKustomState createState() => _TransaksiKustomState();
}

class _TransaksiKustomState extends State<TransaksiKustom>
    with SingleTickerProviderStateMixin {

String totalPembayaran = "0";
  String number = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        number = " ";
        totalPembayaran = "0";
      } 
      else if(buttonText == "0" || buttonText =="000"){
        if(totalPembayaran == "0"){
          totalPembayaran = "0";
        }
        else {
        number = number + buttonText;
        totalPembayaran = number;
      }
      }
      else {
        number = number + buttonText;
        totalPembayaran = number;
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
              "Transaksi",
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
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 45,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text("Total Pembayaran",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontFamily: 'CircularStd-Bold'))),
                                ),
                                Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Rp ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 42.0,
                                                  fontFamily:
                                                      'CircularStd-Bold')),
                                          Text("$totalPembayaran",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 42.0,
                                                  fontFamily:
                                                      'CircularStd-Bold')),
                                        ])
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
          drawer: AppDrawer(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.8,
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
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          hintText: "Keterangan (Wajib Diisi)",
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
                    SizedBox(height: 40),
                    Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ButtonTheme(
                            height: 50,
                            padding: EdgeInsets.all(15),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(55.0),
                              ),
                              color: Color.fromRGBO(54, 58, 155, 1),
                               child: Center(
                                child: Text("Tambah Menu",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontFamily: 'CircularStd-Bold'))),
                              onPressed: () {},
                            )))
                  ]),
                ),
                checkOut(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget checkOut() {
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
                  padding: EdgeInsets.all(15),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Color.fromRGBO(54, 58, 155, 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "2 pesanan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: 'CircularStd-Book'),
                              ),
                            ],
                          ),
                          Text(
                            "Rp 10.000",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'CircularStd-Bold'),
                          ),
                        ]),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutOrder(),
                          ));
                    },
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 7,
                height: 50,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(54, 58, 155, 1),
                    borderRadius: BorderRadius.circular(19)),
                child: IconButton(
                  icon: Icon(Icons.view_list),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RiwayatTransaksi(),
                          ));},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
