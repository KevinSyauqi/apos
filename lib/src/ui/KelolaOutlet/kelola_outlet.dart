import 'package:apos/src/bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:apos/src/ui/KelolaOutlet/kelola_outlet_list.dart';
import 'package:apos/src/ui/KelolaOutlet/kelola_outlet_tambah.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KelolaOutletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OutletBloc(),
      child: KelolaOutlet(),
    );
  }
}



class KelolaOutlet extends StatefulWidget {


  _KelolaOutletState createState() => _KelolaOutletState();
}

class _KelolaOutletState extends State<KelolaOutlet>
    with SingleTickerProviderStateMixin {
  TabController controller;
  OutletBloc _outletBloc;

  @override
  void initState() {
    _outletBloc = BlocProvider.of<OutletBloc>(context);
    _outletBloc.add(FetchingAllOutletStore());
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _outletBloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Kelola Outlet",
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
                          height: 80,
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
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 2.0),
                                alignment: Alignment.center,
                                height: 60.0,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(234, 234, 234, 1),
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Pencarian Outlet",
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16.0,
                                          fontFamily: 'CircularStd-Book'),
                                      prefixIcon: Icon(Icons.search,
                                          color: Colors.grey)),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(55),
                            topRight: Radius.circular(55))),
                  )
                ],
              ),
              preferredSize: Size(0, 165),
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
                BlocProvider(
                  create: (context) => _outletBloc,
                  child: KelolaListOutlet(),
                ),
                addOutlet(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget addOutlet() {
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
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                // margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Tambah Outlet",
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
                            builder: (context) => TambahOutletPage()),
                      ).then((value){
                        _outletBloc.add(FetchingAllOutletStore());
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
