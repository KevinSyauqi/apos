import 'package:apos/src/ui/login/login_page.dart';
import 'package:flutter/material.dart';

class ValidasiAkunPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(54, 58, 155, 1),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: EdgeInsets.all(55.0),
              child: Center(
                child: Image(image: AssetImage('images/validasi.png')),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                  margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height / 2.5),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Validasi Akun",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36.0,
                              fontFamily: 'CircularStd-Bold')),
                      Container(
                        margin: EdgeInsets.all(50),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                            "Silahkan cek email ya. Validasi akun kamu melalui link yang telah diberikan. Terima kasih",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: 'CircularStd-Bold')),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2,
                        padding: EdgeInsets.only(top: 5, bottom: 15),
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          color: Color.fromRGBO(54, 58, 155, 1),
                          elevation: 5,
                          onPressed: () {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginPage()),
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(100.0))),
                          child: Text("Kembali",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'CircularStd-Bold')),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
