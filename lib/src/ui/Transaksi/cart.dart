import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/Transaksi/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CartPage extends StatelessWidget {
  final List<Menu> menus;
  final int totalPrice;

  CartPage({this.menus, this.totalPrice});

  @override
  Widget build(BuildContext context) {
    print(menus.length);
    print(totalPrice);
    return BlocProvider<CheckoutBloc>(
        create: (context) => CheckoutBloc()
          ..add(CheckoutCart(orders: menus, totalPrice: totalPrice)),
        child: KeranjangMenu());
  }
}

class KeranjangMenu extends StatefulWidget {
  _KeranjangMenuState createState() => _KeranjangMenuState();
}

class _KeranjangMenuState extends State<KeranjangMenu>
    with SingleTickerProviderStateMixin {
  String nominalBayar = "0";
  String number = "";
  CheckoutBloc _checkoutBloc;

  _onPayLaterButtonPressed(
      List<SalesLineItem> listSalesLineItem, int totalPrice) async {
    await _checkoutBloc.add(
        PayLater(listSalesLineItem: listSalesLineItem, totalPrice: totalPrice));
  }

  @override
  void initState() {
    _checkoutBloc = BlocProvider.of<CheckoutBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Keranjang",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'CircularStd-Bold'),
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => TransaksiKustom(),
                  //     ));
                },
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
                      Icon(Icons.backspace, color: Colors.white, size: 18),
                      SizedBox(width: 10),
                      Text(
                        "Bayar Nanti",
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
                                  height: 20,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text("Total Pembayaran",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontFamily: 'CircularStd-Bold'))),
                                ),
                                Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: BlocBuilder<CheckoutBloc,
                                            CheckoutState>(
                                        builder: (context, state) {
                                      if (state is CheckoutLoaded) {
                                        return Center(
                                            child: Text(
                                                "Rp " +
                                                    (state.totalPrice
                                                        .toString()),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 42.0,
                                                    fontFamily:
                                                        'CircularStd-Bold')));
                                      } else
                                        return Center(
                                            child: CircularProgressIndicator());
                                    })),
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
          // drawer: AppDrawer(),
          body: BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
            if (state is CheckoutSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pop(context);
              });
            }
            if (state is CheckoutError) {
              return Center(child: Text("Error"));
            }
            if (state is CheckoutLoading) {
              return Center(child: CircularProgressIndicator());
            }if(state is CheckoutLoaded){
              final currentState = state as CheckoutLoaded;
              print(currentState.listSalesLineItem.length);
              final listOrder = currentState.listSalesLineItem;
              print("Jumlah Sales Line Item :" + listOrder.length.toString());
              final menus = currentState.menus;
              return ModalProgressHUD(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      ListView.builder(
                          itemCount: listOrder.length,
                          itemBuilder: (_, index) {
                            SalesLineItem item = listOrder[index];
                            return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:
                                          Color.fromRGBO(224, 224, 224, 1),
                                          width: 1.0)),
                                  color: Color.fromRGBO(250, 250, 250, 1),
                                ),
                                width: double.infinity,
                                height: 80,
                                margin: EdgeInsets.symmetric(horizontal: 25),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 55,
                                        height: 55,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                          color:
                                          Color.fromRGBO(234, 234, 234, 1),
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  menus
                                                      .firstWhere((menu) =>
                                                  menu.id_outlet_menu ==
                                                      item.id_outlet_menu)
                                                      .name_menu
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.0,
                                                      fontFamily:
                                                      'CircularStd-Bold')),
                                              Text(
                                                  "Rp " +
                                                      menus
                                                          .firstWhere((menu) =>
                                                      menu.id_outlet_menu ==
                                                          item
                                                              .id_outlet_menu)
                                                          .price
                                                          .toString() +
                                                      " x " +
                                                      item.qty.toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0,
                                                      fontFamily:
                                                      'CircularStd-Book'))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                      "Rp " +
                                                          (menus
                                                              .firstWhere((menu) =>
                                                          menu.id_outlet_menu ==
                                                              item
                                                                  .id_outlet_menu)
                                                              .price *
                                                              item.qty)
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                          fontFamily:
                                                          'CircularStd-Bold')),
                                                  SizedBox(width: 15),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                        padding:
                                                        EdgeInsets.only(
                                                            bottom: 4),
                                                        width: 32,
                                                        height: 32,
                                                        alignment:
                                                        Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Color.fromRGBO(
                                                                54, 58, 155, 1),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                13)),
                                                        child: Text("x",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16.0,
                                                                fontFamily:
                                                                'CircularStd-Bold'))),
                                                  ),
                                                ],
                                              ))),
                                    ]));
                          }),
                      checkout(listOrder, currentState.totalPrice),
                    ],
                  ),
                ),
                inAsyncCall: state is CheckoutInProgress,
                opacity: 0.7,
                color: Color.fromRGBO(54, 58, 155, 1),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
        ),
      ]),
    );
  }

  Widget checkout(List<SalesLineItem> listSalesLineItem, int totalPrice) {
    return Positioned(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
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
                            Text(
                              "Bayar Nanti",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'CircularStd-Bold'),
                            )
                          ]),
                      onPressed: () async {
                        if (_checkoutBloc.state is CheckoutLoaded) {
                          _onPayLaterButtonPressed(
                              listSalesLineItem, totalPrice);
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
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
                            Text(
                              "Bayar Sekarang",
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
                              builder: (context) => CheckoutMenu(),
                            ));
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
