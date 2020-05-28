import 'package:flutter/material.dart';

class TambahOutletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text ("Tambah Outlet",
          style: TextStyle(
            color: Colors.white, fontFamily: 'CircularStd-Bold')),
        backgroundColor: Colors.transparent,
        // elevation : 0.0,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            color: Color.fromRGBO(234, 234, 234, 1),
          ),
           Image(
            image: new AssetImage('images/store.png'),
            width: 200.0,
            height: 200.0,
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.height * 0.18,
            child: RawMaterialButton(
              onPressed: () {},
              elevation: 2.0,
              fillColor: Color.fromRGBO(54, 58, 155, 1),
              child: Icon(
                Icons.camera_alt,
                size: 30.0,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            ),
          ),
          
          Positioned(
            bottom: 0,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                    topRight: Radius.circular(60.0),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(252, 195, 108, 1),
                        Color.fromRGBO(253, 166, 125, 1),
                  ])),
              ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(bottom: 5.0),
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("Tambah Outlet",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36.0,
                          fontFamily: 'CircularStd-Bold')),

              Card(
                margin: EdgeInsets.fromLTRB(35, 20, 35, 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.store_mall_directory,
                        color: Color.fromRGBO(179, 179, 183, 1),
                      ),
                      hintText: "Nama Outlet",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(179, 179, 183, 1),
                        fontSize: 13.0,
                        fontFamily: 'CircularStd-Book'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                          BorderRadius.all(Radius.circular(20.0))),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),

              Card(
                margin: EdgeInsets.fromLTRB(35, 5, 35, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.add_location,
                        color: Color.fromRGBO(179, 179, 183, 1),
                      ),
                      hintText: "Alamat Outlet",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(179, 179, 183, 1),
                        fontSize: 13.0,
                        fontFamily: 'CircularStd-Book'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                          BorderRadius.all(Radius.circular(20.0))),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 16.0)),
                ),
              ),

              Card(
                margin: EdgeInsets.fromLTRB(35, 5, 35, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Color.fromRGBO(179, 179, 183, 1),
                      ),
                      hintText: "No. Telepon",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(179, 179, 183, 1),
                        fontSize: 13.0,
                        fontFamily: 'CircularStd-Book'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                            BorderRadius.all(Radius.circular(20.0))),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 16.0)),
                ),
              ),

              Card(
                margin: EdgeInsets.fromLTRB(35, 5, 35, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.description,
                        color: Color.fromRGBO(179, 179, 183, 1),
                      ),
                      hintText: "Deskripsi",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(179, 179, 183, 1),
                        fontSize: 13.0,
                        fontFamily: 'CircularStd-Book'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                            BorderRadius.all(Radius.circular(20.0))),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 16.0)),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.only(top: 5, bottom: 15),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  color: Color.fromRGBO(54, 58, 155, 1),
                  elevation: 5,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100.0))),
                  child: Text("Tambah",
                    style: TextStyle(
                      color: Colors.white, fontFamily: 'CircularStd-Bold')),
                ),
              ),
            
            ],
          ),
        ))
      ],
    ));
  }
}