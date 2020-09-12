import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/bloc/manage_stock/manage_stock_bloc.dart';
import 'package:apos/src/bloc/manage_stock/manage_stock_event.dart';
import 'package:apos/src/bloc/manage_stock/manage_stock_state.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/History//history_page.dart';
import 'package:apos/src/ui/ManageOrder/checkout_cart_page.dart';
import 'package:apos/src/ui/ManageOrder/checkout_order_page.dart';
import 'package:apos/src/ui/ManageOrder/list_order_page.dart';
import 'package:apos/src/ui/ManageOrder/transaksi_kustom.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManageStockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ManageStockBloc>(
        create: (context) => ManageStockBloc(),
      ),
      BlocProvider<CartBloc>(
        create: (context) => CartBloc(),
      ),
    ], child: ManageStock());
  }
}

class ManageStock extends StatefulWidget {
  _ManageStockState createState() => _ManageStockState();
}

class _ManageStockState extends State<ManageStock>
    with SingleTickerProviderStateMixin {
  TabController controller;
  ManageStockBloc _manageStockBloc;
  CartBloc _cartBloc;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    _manageStockBloc = BlocProvider.of<ManageStockBloc>(context);
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _manageStockBloc.add(FetchStockMenus());
    _cartBloc.add(LoadCart());

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _manageStockBloc.close();
    _cartBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Kelola Stok Menu",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'CircularStd-Bold'),
            ),
            bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  // Container(
                  //   child: Column(
                  //     children: <Widget>[
                  //       Container(
                  //         margin: EdgeInsets.symmetric(horizontal: 30),
                  //         width: MediaQuery.of(context).size.width,
                  //         height: 80,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(25),
                  //           color: Colors.white,
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey,
                  //               offset: Offset(0.0, 2.0),
                  //               blurRadius: 5.0,
                  //             ),
                  //           ],
                  //         ),
                  //         child: Padding(
                  //             padding: EdgeInsets.all(15),
                  //             child: Container(
                  //               margin: EdgeInsets.symmetric(vertical: 2.0),
                  //               alignment: Alignment.center,
                  //               height: 60.0,
                  //               decoration: BoxDecoration(
                  //                   color: Color.fromRGBO(234, 234, 234, 1),
                  //                   borderRadius: BorderRadius.circular(15.0)),
                  //               child: TextField(
                  //                 decoration: InputDecoration(
                  //                     border: InputBorder.none,
                  //                     hintText: "Pencarian Menu",
                  //                     hintStyle: TextStyle(
                  //                         color: Colors.grey,
                  //                         fontSize: 16.0,
                  //                         fontFamily: 'CircularStd-Book'),
                  //                     prefixIcon: Icon(Icons.search,
                  //                         color: Colors.grey)),
                  //               ),
                  //             )),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 25),
                  // ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70, right: 70),
                      child: TabBar(
                        controller: controller,
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(252, 195, 108, 1),
                              width: 5,
                            ),
                            insets: EdgeInsets.symmetric(horizontal: 20.0)),
                        tabs: <Widget>[
                          Tab(
                            child: Text("Makanan",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontFamily: 'CircularStd-Bold')),
                          ),
                          Tab(
                            child: Text("Minuman",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontFamily: 'CircularStd-Bold')),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              preferredSize: Size(0, 70),
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
                BlocBuilder<ManageStockBloc, ManageStockState>(
                    builder: (context, state) {
                  if (state is ManageStockInitialized) {
                    return Center(child: Text("Unitialized State"));
                  } else if (state is ManageStockLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ManageStockError) {
                    return Center(child: Text('error'));
                  } else if (state is ManageStockLoaded) {
                    return TabBarView(
                      controller: controller,
                      children: <Widget>[
                        getDataMenu(state.foods, state.foodMenuCounter),
                        getDataMenu(state.drinks, state.drinkMenuCounter)
                      ],
                    );
                  }
                  return Center(child: Text("Belum ada menu nih"));
                }),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget getDataMenu(List<Menu> menus, List<int> itemCount) {
    return Container(
      // margin: EdgeInsets.only(bottom: 90),
      child: BlocBuilder(
        bloc: BlocProvider.of<ManageStockBloc>(context),
        builder: (context, state) {
          if (state is ManageStockInitialized) {
            return Center(child: Text("Unitialized State"));
          } else if (state is ManageStockEmpty) {
            return Center(child: Text("Belum ada menu nih"));
          } else if (state is ManageStockLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ManageStockError) {
            return Center(child: Text('error'));
          }

          return ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              itemCount: menus.length,
              itemBuilder: (BuildContext context, int index) {
                Menu menu = menus[index];
                if (itemCount[index] == null) itemCount[index] = 0;
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(224, 224, 224, 1),
                            width: 1.0)),
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
                      Container(
                        width: 220,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              menu.name_menu,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontFamily: 'CircularStd-Bold'),
                              overflow: TextOverflow.fade,
                              softWrap: true,
                            ),
                            Row(children: <Widget>[
                              Text("Stok : ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontFamily: 'CircularStd-Book')),
                              Text(menu.price.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontFamily: 'CircularStd-Book')),
                              Text(" | Prediksi : ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontFamily: 'CircularStd-Book')),
                            ])
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 13),
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
                                    icon: Icon(Icons.add),
                                    iconSize: 17,
                                    color: Colors.white,
                                    onPressed: () {
                                      _showAlertManageAddStock();
                                    }),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Container(
                                width: 32,
                                height: 32,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(54, 58, 155, 1),
                                    borderRadius: BorderRadius.circular(13)),
                                child: IconButton(
                                    icon: Icon(Icons.remove),
                                    iconSize: 17,
                                    color: Colors.white,
                                    onPressed: () {
                                      _showAlertManageRemoveStock();
                                    }),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
          ;
        },
      ),
    );
  }

  void _showAlertManageRemoveStock() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text("Pengurangan Stok Menu",
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
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: "Kurangi Stok Menu",
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
                          EdgeInsets.symmetric(vertical: 18, horizontal: 48),
                      color: Color.fromRGBO(54, 58, 155, 1),
                      elevation: 5,
                      onPressed: () => Navigator.pop(context),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: Text("Simpan",
                          style: TextStyle(
                            color: Colors.white,
                          ))),
                  SizedBox(width: 10),
                  RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 48),
                      color: Color.fromRGBO(234, 234, 234, 1),
                      elevation: 5,
                      onPressed: () => Navigator.pop(context),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
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

  void _showAlertManageAddStock() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text("Penambahan Stok Menu",
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
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: "Tambah Stok Menu",
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
                          EdgeInsets.symmetric(vertical: 18, horizontal: 48),
                      color: Color.fromRGBO(54, 58, 155, 1),
                      elevation: 5,
                      onPressed: () => Navigator.pop(context),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: Text("Simpan",
                          style: TextStyle(
                            color: Colors.white,
                          ))),
                  SizedBox(width: 10),
                  RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 48),
                      color: Color.fromRGBO(234, 234, 234, 1),
                      elevation: 5,
                      onPressed: () => Navigator.pop(context),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
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
}
