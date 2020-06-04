import 'package:flutter/material.dart';
import 'package:apos/src/ui/ganti_password_page.dart';

class LupaPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(54, 58, 155, 1),
        body: ListView(
                  children:<Widget>[Stack(
      children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(50.0),
            child: Center(
              child: Image(image: AssetImage('images/splash-1.png')),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height/2,
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
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2),
            height: MediaQuery.of(context).size.height/2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Lupa Password",
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
                          Icons.mail,
                          color: Color.fromRGBO(179, 179, 183, 1),
                        ),
                        hintText: "Masukkan Email Pengguna",
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GantiPasswordPage()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0))),
                    child: Text("Submit",
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'CircularStd-Bold')),
                  ),
                ),
              ],
            ),
          ))
      ],
    ),] 
        ));
  }
}
