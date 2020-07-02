import 'package:apos/src/ui/RiwayatTransaksi/riwayat_transaksi.dart';
import 'package:apos/src/ui/Transaksi/checkout.dart';
import 'package:apos/src/ui/Transaksi/transaksi_menu.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';

class TransaksiKustom extends StatefulWidget {
  _TransaksiKustomState createState() => _TransaksiKustomState();
}

class _TransaksiKustomState extends State<TransaksiKustom>
    with SingleTickerProviderStateMixin {
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
            actions: <Widget>[
              GestureDetector(
                onTap: () {},
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
                      Icon(Icons.apps, color: Colors.white, size: 18),
                      SizedBox(width: 3),
                      Text(
                        "Menu",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'CircularStd-Bold'),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransaksiKustom(),
                      ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.dialpad, color: Colors.white, size: 18),
                      SizedBox(width: 3),
                      Text(
                        "Kustom",
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
                    SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 100,
                            child: Center(
                                child: Text("7",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 50.0,
                                        fontFamily: 'CircularStd-Bold'))),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 100,
                            child: Center(
                                child: Text("8",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 50.0,
                                        fontFamily: 'CircularStd-Bold'))),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 100,
                            child: Center(
                                child: Text("9",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 50.0,
                                        fontFamily: 'CircularStd-Bold'))),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 100,
                            child: Center(
                                child: Text("4",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 50.0,
                                        fontFamily: 'CircularStd-Bold'))),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 100,
                            child: Center(
                                child: Text("5",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 50.0,
                                        fontFamily: 'CircularStd-Bold'))),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 100,
                            child: Center(
                                child: Text("6",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 50.0,
                                        fontFamily: 'CircularStd-Bold'))),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 100,
                            child: Center(
                                child: Text("1",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 50.0,
                                        fontFamily: 'CircularStd-Bold'))),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 100,
                            child: Center(
                                child: Text("2",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 50.0,
                                        fontFamily: 'CircularStd-Bold'))),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 100,
                            child: Center(
                                child: Text("3",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 50.0,
                                        fontFamily: 'CircularStd-Bold'))),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 100,
                            child: Center(
                                child: Text("0",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 50.0,
                                        fontFamily: 'CircularStd-Bold'))),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 100,
                            child: Center(
                                child: Text("000",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 50.0,
                                        fontFamily: 'CircularStd-Bold'))),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 100,
                            child: Center(
                                child: Text("C",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 50.0,
                                        fontFamily: 'CircularStd-Bold'))),
                          ),
                        ]),
                    SizedBox(height: 20),
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
                            builder: (context) => CheckoutMenu(),
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
