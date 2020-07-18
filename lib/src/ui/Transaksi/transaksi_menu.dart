import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/RiwayatTransaksi/riwayat_transaksi.dart';
import 'package:apos/src/ui/Transaksi/cart.dart';
import 'package:apos/src/ui/Transaksi/checkout.dart';
import 'package:apos/src/ui/Transaksi/transaksi_kustom.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransaksiMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<TransactionMenuBloc>(
        create: (context) => TransactionMenuBloc(),
      ),
      BlocProvider<CheckoutBloc>(
        create: (context) => CheckoutBloc(),
      ),
    ], child: TransaksiMenu());
  }
}

class TransaksiMenu extends StatefulWidget {
  _TransaksiMenuState createState() => _TransaksiMenuState();
}

class _TransaksiMenuState extends State<TransaksiMenu>
    with SingleTickerProviderStateMixin {
  TabController controller;
  TransactionMenuBloc _trscMenuBloc;
  CheckoutBloc _checkoutBloc;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    _trscMenuBloc = BlocProvider.of<TransactionMenuBloc>(context);
    _checkoutBloc = BlocProvider.of<CheckoutBloc>(context);
    _trscMenuBloc.add(FetchMenus());
    _checkoutBloc.add(LoadCart());

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _trscMenuBloc.close();
    _checkoutBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Transaksi",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'CircularStd-Bold'),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.apps, color: Colors.white, size: 18),
                    SizedBox(width: 3),
                    Text(
                      "Menu",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'CircularStd-Bold'),
                    )
                  ],
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransaksiKustom(),
                      ));
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
                      Icon(Icons.dialpad, color: Colors.white, size: 18),
                      SizedBox(width: 3),
                      Text(
                        "Kustom",
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
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
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
                                      hintText: "Pencarian Menu",
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
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Stack(
              children: <Widget>[
                BlocBuilder<TransactionMenuBloc,TransactionMenuState>(
                    builder: (context, state) {
                      if (state is TrscMenuInitialized) {
                        return Center(child: Text("Unitialized State"));
                      } else if (state is TrscMenuLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is TrscMenuError) {
                        return Center(child: Text('error'));
                      } else if (state is TrscMenuLoaded) {
                        return TabBarView(
                          controller: controller,
                          children: <Widget>[
                            getDataMenu(state.foods, state.foodMenuCounter),
                            getDataMenu(state.drinks, state.drinkMenuCounter)],
                        );
                      }
                      return Center(child: Text("Belum ada menu nih"));
                    }
                ),
                checkOut(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget getDataMenu(List<Menu> menus, List<int> itemCount) {
    return Container(
      margin: EdgeInsets.only(bottom: 90),
      child: BlocBuilder(
        bloc: BlocProvider.of<TransactionMenuBloc>(context),
        builder: (context, state) {
          if (state is TrscMenuInitialized) {
            return Center(child: Text("Unitialized State"));
          } else if (state is TrscMenuEmpty) {
            return Center(child: Text("Belum ada menu nih"));
          } else if (state is TrscMenuLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TrscMenuError) {
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
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(menu.name_menu,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontFamily: 'CircularStd-Bold')),
                            Text(menu.price.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: 'CircularStd-Book')),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              BlocBuilder<CheckoutBloc, CheckoutState>(
                                builder: (context, state) {
                                  if (state is CheckoutLoading) {
                                    return CircularProgressIndicator();
                                  }
                                  if (state is CheckoutLoaded) {
                                    return Container(
                                      width: 32,
                                      height: 32,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(54, 58, 155, 1),
                                          borderRadius: BorderRadius.circular(
                                              13)),
                                      child: IconButton(
                                          icon: Icon(Icons.remove),
                                          iconSize: 17,
                                          color: Colors.white,
                                          onPressed: () {
                                            if (itemCount[index] > 0) {
                                              BlocProvider.of<CheckoutBloc>(
                                                  context)
                                                  .add(RemoveFromCheckout(
                                                  menu: menu));
                                              setState(() {
                                                itemCount[index]--;
                                              });
                                            }
                                          }
                                      ),
                                    );
                                  }
                                  return Text("Terjadi Kesalahan");
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, left: 15.0),
                                child: Text(itemCount[index].toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontFamily: 'CircularStd-Bold')),
                              ),
                              BlocBuilder<CheckoutBloc, CheckoutState>(
                                builder: (context, state) {
                                  if (state is CheckoutLoading) {
                                    return CircularProgressIndicator();
                                  }
                                  if (state is CheckoutLoaded) {
                                    return Container(
                                      width: 32,
                                      height: 32,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(54, 58, 155, 1),
                                          borderRadius: BorderRadius.circular(
                                              13)),
                                      child: IconButton(
                                          icon: Icon(Icons.add),
                                          iconSize: 17,
                                          color: Colors.white,
                                          onPressed: () {
                                            BlocProvider.of<CheckoutBloc>(
                                                context)
                                                .add(AddCheckout(menu: menu));
                                            setState(() {
                                              itemCount[index]++;
                                            });
                                          }
                                      ),
                                    );
                                  }
                                  return Text("Terjadi Kesalahan");
                                },
                              )
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

  Widget checkOut() {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state is CheckoutSuccess) {
          _checkoutBloc.add(LoadCart());
        }
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.4,
                    margin: EdgeInsets.fromLTRB(20, 20, 10, 20),
                    alignment: Alignment.center,
                    child: ButtonTheme(
                      height: 50,
                      padding: EdgeInsets.all(15),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Color.fromRGBO(54, 58, 155, 1),
                        child: (state is CheckoutLoaded)
                            ? Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  state.menus.length.toString() +
                                      " Pesanan",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontFamily: 'CircularStd-Book'),
                                ),
                              ],
                            ),
                            Text(
                              "Rp " + state.totalPrice.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'CircularStd-Bold'),
                            ),
                          ],
                        )
                            : Text("Terjadi Kesalahan"),
                        onPressed: () {
                          (state is CheckoutLoaded)
                              ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CartPage(
                                        menus: state.menus,
                                        totalPrice: state.totalPrice),
                              )).then((value) {
                            if(value == "Success"){
                              _checkoutBloc.add(LoadCart());
                              _trscMenuBloc.add(FetchMenus());
                            }
                          })
                              : print("State bukan checkloaded");
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 7,
                    height: 50,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(54, 58, 155, 1),
                        borderRadius: BorderRadius.circular(19)),
                    child: IconButton(
                      icon: Icon(Icons.view_list),
                      iconSize: 25,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RiwayatTransaksi(),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
