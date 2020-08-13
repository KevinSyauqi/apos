import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/KelolaOutlet/kelola_outlet_edit.dart';
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
  OutletBloc _outletBloc;

  @override
  void initState() {
    _outletBloc = BlocProvider.of<OutletBloc>(context);
    _outletBloc.add(FetchingAllOutletStore());
    super.initState();
  }

  @override
  void dispose() {
    _outletBloc.close();
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
                  child: BlocBuilder(
                      bloc: BlocProvider.of<OutletBloc>(context),
                      builder: (context, state) {
                        if (state is FetchingAllOutletStore) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is OutletListLoaded) {
                          final outletListLoaded = state as OutletListLoaded;
                          final outlets = outletListLoaded.outlets;
                          return buildOutletList(outlets);
                        }
                        if(state is OutletEmpty){
                          return Center(child: Text("Belum ada outlet nih"));
                        }
                        if(state is OutletLoading){
                          return Center(child: CircularProgressIndicator());
                        }
                        return Center(child: Text(""));
                      }),
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

  void _showAlertDelete() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text("Anda yakin akan menghapusnya?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'CircularStd-Bold')),
            actions: <Widget>[
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
                      child: Text("Hapus",
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

  Widget buildOutletList(List<Outlet> outlets) {
    return ListView.builder(
        itemCount: outlets.length,
        itemBuilder: (BuildContext context, int index) {
          Outlet outlet = outlets[index];
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
                        Text(outlet.name_outlet,

                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontFamily: 'CircularStd-Bold')),
                        Text(outlet.address_outlet,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'CircularStd-Book')),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(54, 58, 155, 1),
                              borderRadius: BorderRadius.circular(13)),
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            iconSize: 17,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditKelolaOutlet(value:outlet)),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(54, 58, 155, 1),
                              borderRadius: BorderRadius.circular(13)),
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            iconSize: 17,
                            color: Colors.white,
                            onPressed: () {
                              _showAlertDelete();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
