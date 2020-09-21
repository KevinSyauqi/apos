import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/History//history_page.dart';
import 'package:apos/src/ui/ManageOrder/checkout_cart_page.dart';
import 'package:apos/src/ui/ManageOrder/checkout_order_page.dart';
import 'package:apos/src/ui/ManageOrder/list_order_page.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManageOrderPage extends StatelessWidget {
  final String id_order;

  ManageOrderPage({this.id_order});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ManageOrderBloc>(
        create: (context) => ManageOrderBloc(),
      ),
      BlocProvider<CartBloc>(
        create: (context) {
          if (id_order == null) {
            return CartBloc()..add(LoadCart());
          } else
            return CartBloc()..add(LoadCart(id_order: id_order));
        },
      ),
    ], child: ManageOrder());
  }
}

class ManageOrder extends StatefulWidget {
  _ManageOrderState createState() => _ManageOrderState();
}

class _ManageOrderState extends State<ManageOrder>
    with SingleTickerProviderStateMixin {
  TabController controller;
  ManageOrderBloc _manageOrderBloc;
  CartBloc _cartBloc;
  String id_order;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    _manageOrderBloc = BlocProvider.of<ManageOrderBloc>(context);
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _manageOrderBloc.add(FetchMenus());

    BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartLoaded) {
          if (state.id_order != null) {
            setState(() {
              id_order = state.id_order;
            });
          }
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _manageOrderBloc.close();
    _cartBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: (state.id_order == null)
                  ? Text(
                      "Kelola Pesanan",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'CircularStd-Bold'),
                    )
                  : Text(
                      "Tambah Pesanan",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'CircularStd-Bold'),
                    ),
              bottom: PreferredSize(
                child: Column(
                  children: <Widget>[
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
            drawer: (state.id_order == null) ? AppDrawer() : null,
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  BlocBuilder<ManageOrderBloc, ManageOrderState>(
                      builder: (context, state) {
                    if (state is ManageOrderInitialized) {
                      return Center(child: Text("Unitialized State"));
                    } else if (state is ManageOrderLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ManageOrderError) {
                      return Center(child: Text('error'));
                    } else if (state is ManageOrderLoaded) {
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
                  checkOut(),
                ],
              ),
            ),
          );
        } else
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Kelola Pesanan",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'CircularStd-Bold'),
              ),
              bottom: PreferredSize(
                child: Column(
                  children: <Widget>[
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
          );
      },
    );
  }

  Widget getDataMenu(List<Menu> menus, List<int> itemCount) {
    return Container(
      margin: EdgeInsets.only(bottom: 90),
      child: BlocBuilder(
        bloc: BlocProvider.of<ManageOrderBloc>(context),
        builder: (context, state) {
          if (state is ManageOrderInitialized) {
            return Center(child: Text("Unitialized State"));
          } else if (state is ManageOrderEmpty) {
            return Center(child: Text("Belum ada menu nih"));
          } else if (state is ManageOrderLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ManageOrderError) {
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
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 55,
                        height: 55,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage("https://apos-server-kota202.et.r.appspot.com/manageMenu/photo?id_menu="+menu.id_menu)
                          ),
                          color: Color.fromRGBO(234, 234, 234, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Container(
                        width: 150,
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
                              Text("Rp ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontFamily: 'CircularStd-Book')),
                              Text(
                                  FlutterMoneyFormatter(
                                          amount: double.parse(
                                              menu.price.toString()))
                                      .output
                                      .withoutFractionDigits,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontFamily: 'CircularStd-Book')),
                            ]),
                          ],
                        ),
                      ),
                      (menu.quantity_stock != 0)
                          ? Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        BlocBuilder<CartBloc, CartState>(
                                          builder: (context, state) {
                                            if (state is CartLoading) {
                                              return CircularProgressIndicator();
                                            }
                                            if (state is CartLoaded) {
                                              return Container(
                                                width: 32,
                                                height: 32,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        54, 58, 155, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(13)),
                                                child: IconButton(
                                                    icon: Icon(Icons.remove),
                                                    iconSize: 17,
                                                    color: Colors.white,
                                                    onPressed: () {
                                                      if (itemCount[index] > 0) {
                                                        BlocProvider.of<CartBloc>(
                                                                context)
                                                            .add(RemoveFromCart(
                                                                id_order:
                                                                    state.id_order,
                                                                menu: menu));
                                                        setState(() {
                                                          itemCount[index]--;
                                                        });
                                                      }
                                                    }),
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
                                        BlocBuilder<CartBloc, CartState>(
                                          builder: (context, state) {
                                            if (state is CartLoading) {
                                              return CircularProgressIndicator();
                                            }
                                            if (state is CartLoaded) {
                                              return Container(
                                                width: 32,
                                                height: 32,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        54, 58, 155, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(13)),
                                                child: IconButton(
                                                    icon: Icon(Icons.add),
                                                    iconSize: 17,
                                                    color: Colors.white,
                                                    onPressed: () {
                                                      if(itemCount[index] < menu.quantity_stock){
                                                        BlocProvider.of<CartBloc>(
                                                            context)
                                                            .add(AddToCart(
                                                            id_order:
                                                            state.id_order,
                                                            menu: menu));
                                                        setState(() {
                                                          itemCount[index]++;
                                                        });
                                                      }
                                                    }),
                                              );
                                            }
                                            return Text("Terjadi Kesalahan");
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Tersedia " + menu.quantity_stock.toString() + " porsi",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontFamily: 'CircularStd-Bold'),
                                      overflow: TextOverflow.fade,
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                            child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  height: 30,
                                  width: 100,
                                  child: Center(
                                    child: Text("Habis",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14.0,
                                            fontFamily: 'CircularStd-Bold')),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 0, 0.05),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ],
                            ),
                          ),
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
    String id_order;
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CheckoutSuccess) {
          _cartBloc.add(LoadCart());
        }
        if (state is CartLoaded) {
          id_order = state.id_order;
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
                    width: (id_order == null)
                        ? MediaQuery.of(context).size.width / 1.4
                        : MediaQuery.of(context).size.width / 1.2,
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
                        child: (state is CartLoaded)
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
                                    "Rp " +
                                        FlutterMoneyFormatter(
                                                amount: double.parse(state
                                                    .totalPrice
                                                    .toString()))
                                            .output
                                            .withoutFractionDigits,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontFamily: 'CircularStd-Bold'),
                                  ),
                                ],
                              )
                            : Text("Terjadi Kesalahan"),
                        onPressed: () {
                          if (state is CartLoaded) {
                            if (state.menus.length == 0) {
                              _showEmptyCartAlert();
                            } else {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  if (id_order == null) {
                                    return CheckoutCartPage(
                                        menus: state.menus,
                                        totalPrice: state.totalPrice);
                                  } else
                                    return CheckoutCartPage(
                                        id_order: id_order,
                                        menus: state.menus,
                                        totalPrice: state.totalPrice);
                                },
                              )).then((value) {
                                if (value == "Success") {
                                  _cartBloc.add(LoadCart());
                                  _manageOrderBloc.add(FetchMenus());
                                }
                                if (value == "Done") {
                                  Navigator.pop(context, "Done");
                                }
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  (id_order == null)
                      ? Container(
                          width: MediaQuery.of(context).size.width / 7,
                          height: 52,
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(54, 58, 155, 1),
                              borderRadius: BorderRadius.circular(19)),
                          child: GestureDetector(
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.listAlt,
                                size: 22,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListOrderPage(),
                                  ));
                            },
                          ),
                        )
                      : Text("")
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEmptyCartAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text("Keranjang Masih Kosong ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'CircularStd-Bold')),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 30),
                            color: Color.fromRGBO(54, 58, 155, 1),
                            elevation: 5,
                            onPressed: () => Navigator.pop(context),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            child: Text("Kembali",
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                      ]),
                ),
              )
            ],
          );
        });
  }
}
