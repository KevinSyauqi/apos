import 'package:apos/src/ui/History//riwayat_transaksi.dart';
import 'package:apos/src/ui/ManageOrder//checkout_page.dart';
import 'package:apos/src/ui/ManageOrder//manage_order_page.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';

class StrukPembayaran extends StatefulWidget {
  _StrukPembayaranState createState() => _StrukPembayaranState();
}

class _StrukPembayaranState extends State<StrukPembayaran>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
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
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          width: MediaQuery.of(context).size.width,
                          height: 120,
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
                                Text("NAMA TOKO",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25.0,
                                        fontFamily: 'CircularStd-Bold')),
                                Text("Alamat Outlet",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontFamily: 'CircularStd-Book')),
                                Text("No Telp Outlet",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontFamily: 'CircularStd-Book')),
                                Text("Nama Pegawai",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontFamily: 'CircularStd-Bold'))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          width: MediaQuery.of(context).size.width,
                          height: 175,
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
                                Text("Kamis, 20 Juli 2020",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontFamily: 'CircularStd-Book')),
                                Text("Transaksi No #",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28.0,
                                        fontFamily: 'CircularStd-Bold')),
                                Text("Total Pembayaran",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontFamily: 'CircularStd-Book')),
                                Text("Rp 120.000",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25.0,
                                        fontFamily: 'CircularStd-Bold')),
                                Text("Nominal Pembayaran",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontFamily: 'CircularStd-Book')),
                                Text("Rp 120.000",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25.0,
                                        fontFamily: 'CircularStd-Bold')),
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
              preferredSize: Size(0, 390),
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
              buildListMenuTransaction(context),
              bottomButton()
            ]),
          ),
        ),
      ]),
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

  Widget buildListMenuTransaction(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 90),
      child: ListView.builder(
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
                              child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text("Rp 5.000",
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
                      "Kembali Ke Transaksi Menu",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'CircularStd-Bold'),
                    ),
                    onPressed: () {},
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
