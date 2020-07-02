import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';

class RiwayatTransaksi extends StatefulWidget {
  _RiwayatTransaksiState createState() => _RiwayatTransaksiState();
}

class _RiwayatTransaksiState extends State<RiwayatTransaksi>
    with SingleTickerProviderStateMixin {
  Outlet selectedOutlet;
  List<Outlet> outlet = [
    Outlet("Kopo Sayati"),
    Outlet("Sarijadi"),
    Outlet("Kebon Jati")
  ];

  List<DropdownMenuItem> generateItems(List<Outlet> category) {
    List<DropdownMenuItem> items = [];
    for (var item in outlet) {
      items.add(DropdownMenuItem(
        child: Text(item.name),
        value: item,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Riwayat Transaksi",
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
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                      child: Container(
                        
                        padding: EdgeInsets.symmetric(
                            vertical: 3, horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration.collapsed(
                            hintText: 'Pilih Outlet',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(179, 179, 183, 1),
                                fontSize: 13.0,
                                fontFamily: 'CircularStd-Book'),
                          ),
                          isExpanded: true,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontFamily: 'CircularStd-Book'),
                          value: selectedOutlet,
                          items: generateItems(outlet),
                          onChanged: (item) {
                            setState(() {
                              selectedOutlet = item;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                      child: Container(
                        
                        padding: EdgeInsets.symmetric(
                            vertical: 3, horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration.collapsed(
                            hintText: 'Pilih Outlet',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(179, 179, 183, 1),
                                fontSize: 13.0,
                                fontFamily: 'CircularStd-Book'),
                          ),
                          isExpanded: true,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontFamily: 'CircularStd-Book'),
                          value: selectedOutlet,
                          items: generateItems(outlet),
                          onChanged: (item) {
                            setState(() {
                              selectedOutlet = item;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
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
              preferredSize: Size(0, 200),
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
                            borderRadius: BorderRadius.circular(15),
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
                  ]),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class Outlet {
  String name;
  Outlet(this.name);
}
