import 'package:apos/ui/login_page.dart';
import 'package:apos/ui/validasi_akun_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          color: Color.fromRGBO(54, 58, 155, 1),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left:100.0, right: 100.0,top:50, bottom: 120.0),
          child: Center(
            child: Image(image: AssetImage('images/splash-1.png')),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height / 2,
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
              margin: EdgeInsets.only(bottom: 30.0),
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 36.0, fontFamily: 'CircularStd-Bold')),
                    
                    Card(margin: EdgeInsets.fromLTRB(35, 20, 35, 5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person, color: Color.fromRGBO(179, 179, 183, 1),), 
                            hintText: "Masukkan Nama Pengguna", 
                            hintStyle: TextStyle(color:Color.fromRGBO(179, 179, 183, 1), fontSize: 13.0, fontFamily: 'CircularStd-Book'), 
                            filled: true, 
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical:16.0)
                          ),
                        ),
                    ),

                    Card(margin: EdgeInsets.fromLTRB(35, 5, 35, 5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.home, color: Color.fromRGBO(179, 179, 183, 1),), 
                            hintText: "Masukkan Nama Toko", 
                            hintStyle: TextStyle(color:Color.fromRGBO(179, 179, 183, 1), fontSize: 13.0, fontFamily: 'CircularStd-Book'), 
                            filled: true, 
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical:16.0)
                          ),
                        ),
                    ),

                     Card(margin: EdgeInsets.fromLTRB(35, 5, 35, 5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail, color: Color.fromRGBO(179, 179, 183, 1),), 
                            hintText: "Masukkan Email", 
                            hintStyle: TextStyle(color:Color.fromRGBO(179, 179, 183, 1), fontSize: 13.0, fontFamily: 'CircularStd-Book'), 
                            filled: true, 
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical:16.0)
                          ),
                        ),
                    ),

                    Card(margin: EdgeInsets.fromLTRB(35, 5, 35, 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Color.fromRGBO(179, 179, 183, 1),), 
                            hintText: "Masukkan Password", 
                            hintStyle: TextStyle(color:Color.fromRGBO(179, 179, 183, 1), fontSize: 13.0, fontFamily: 'CircularStd-Book'), 
                            filled: true, 
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical:16.0)
                          ),
                        ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width /2,
                      padding: EdgeInsets.only(top: 5, bottom:15),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        color: Color.fromRGBO(54, 58, 155, 1),
                        elevation: 5,
                         onPressed: (){
                           Navigator.push(
                             context, MaterialPageRoute(builder: (context) => ValidasiAkunPage())
                           );
                         },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100.0))),
                        child: Text("Register", style: TextStyle(
                          color: Colors.white,
                        )),
                      ),
                    ),
                    GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
            
                        child: Text("Sudah Daftar?", style: TextStyle(color: Colors.white, fontFamily: 'CircularStd-Book')),  
                      
                    )
                  ],),
            )
            )
      ],
    ));
  }
}
