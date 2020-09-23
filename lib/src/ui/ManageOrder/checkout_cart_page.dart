import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/bloc/manage_order/manage_order_bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CheckoutCartPage extends StatelessWidget {
  final List<Menu> menus;
  final int totalPrice;
  final String id_order;
  final String name_menu;

  CheckoutCartPage({this.id_order, this.menus, this.totalPrice, this.name_menu});

  @override
  Widget build(BuildContext context) {
    print(menus.length);
    print(totalPrice);
    print(id_order);
    return MultiBlocProvider(providers: [
      BlocProvider<CheckoutCartBloc>(
        create: (context) => CheckoutCartBloc(),
      ),
      BlocProvider<CartBloc>(
        create: (context) {
          if (id_order == null) {
            return CartBloc()
              ..add(CheckoutCart(orderMenus: menus, totalPrice: totalPrice));
          } else
            return CartBloc()
              ..add(CheckoutCart(
                  id_order: id_order,
                  orderMenus: menus,
                  totalPrice: totalPrice));
        },
      )
    ], child: CartOrder());
  }
}

class CartOrder extends StatefulWidget {
  _CartOrderState createState() => _CartOrderState();
}

class _CartOrderState extends State<CartOrder>
    with SingleTickerProviderStateMixin {
  String nominalBayar = "0";
  String number = "";
  CartBloc _cartBloc;
  CheckoutCartBloc _checkoutBloc;
  String id_order = null;

  final tableNumberController = TextEditingController();
  final customerNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future _onCreateOrderButtonPressed(
      List<OrderItem> listOrderItem, int totalPrice) async {
    await _checkoutBloc.add(CreateOrderButtonPressed(
        cart: listOrderItem,
        tableNumber: int.parse(tableNumberController.text),
        customerName: customerNameController.text,
        totalPrice: totalPrice));
  }

  Future _onAddToOrderButtonPressed(
      String id_order, List<OrderItem> listOrderItem, int totalPrice) async {
    await _checkoutBloc.add(AddToOrderButtonPressed(
        id_order: id_order,
        cart: listOrderItem,
        totalPrice: totalPrice));
  }

  @override
  void initState() {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _checkoutBloc = BlocProvider.of<CheckoutCartBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _checkoutBloc.close();
    _cartBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CartBloc,CartState>(
        listener: (context,state){
          if(state is CartLoaded){
            imageCache.clearLiveImages();
            if(state.id_order != null){
              setState(() {
                this.id_order = state.id_order;
              });
            }
          }
        },
        child: BlocListener<CheckoutCartBloc,CheckoutCartState>(
          listener: (context,state){
            if(state is AddToOrderSuccess){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context,"Done");
              });
            }
            if(state is CreateOrderSuccess){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context,"Success");
              });
            }
          },
          child: BlocBuilder<CheckoutCartBloc, CheckoutCartState>(
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: state is CreateOrderLoading,
                color: Color.fromRGBO(54, 58, 155, 1),
                progressIndicator: CircularProgressIndicator(),
                child: Stack(children: <Widget>[
                  Scaffold(
                    appBar: AppBar(
                      title: Text(
                        "Cek Keranjang",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: 'CircularStd-Bold'),
                      ),
                      bottom: PreferredSize(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                              ),
                              Container(
                                height: (this.id_order == null) ? 280 : 150,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(250, 250, 250, 1),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40))),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
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
                                          child: BlocBuilder<CartBloc, CartState>(
                                              builder: (context, state) {
                                                if (state is CartLoaded) {
                                                  return Center(
                                                      child: Text(
                                                          "Rp " +
                                                              FlutterMoneyFormatter(
                                                                  amount: double
                                                                      .parse(state
                                                                      .totalPrice
                                                                      .toString()))
                                                                  .output
                                                                  .withoutFractionDigits,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 42.0,
                                                              fontFamily:
                                                              'CircularStd-Bold')));
                                                } else
                                                  return Center(
                                                      child: CircularProgressIndicator());
                                              })),
                                      SizedBox(height: 10),
                                      (this.id_order == null) ? Container(
                                        margin: EdgeInsets.symmetric(horizontal: 25),
                                        width: MediaQuery.of(context).size.width,
                                        alignment: Alignment.center,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15.0)),
                                        child: TextFormField(
                                          controller: tableNumberController,
                                          validator: (value){
                                            if(value.isEmpty){
                                              return "Nomor meja wajib diisi";
                                            }
                                            return null;
                                          },
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.numberWithOptions(),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            hintText: "Nomor Meja",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15.0,
                                                fontFamily: 'CircularStd-Book'),
                                          ),
                                        ),
                                      ) : Center(),
                                      (this.id_order == null) ? Container(
                                        margin: EdgeInsets.symmetric(horizontal: 25),
                                        width: MediaQuery.of(context).size.width,
                                        alignment: Alignment.center,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15.0)),
                                        child: TextFormField(
                                          controller: customerNameController,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            hintText: "Nama Pelanggan",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15.0,
                                                fontFamily: 'CircularStd-Book'),
                                          ),
                                        ),
                                      ) : Center(),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        preferredSize: (this.id_order == null) ? Size(0, 290) : Size(0,180),
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
                    body: BlocBuilder<CheckoutCartBloc, CheckoutCartState>(
                      builder: (context, state) {
                        return BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              if (state is CheckoutSuccess) {
                                return Center(child: Text("Success"));
                              }
                              if (state is CartError) {
                                return Center(child: Text("Error"));
                              }
                              if (state is CartLoading) {
                                return Center(child: CircularProgressIndicator());
                              }
                              if (state is CartLoaded) {
                                final currentState = state as CartLoaded;
                                print(currentState.cart.length);
                                final listOrder = currentState.cart;
                                print("Jumlah Sales Line Item :" +
                                    listOrder.length.toString());
                                final menus = currentState.menus;
                                return Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: <Widget>[
                                      ListView.builder(
                                          itemCount: listOrder.length,
                                          itemBuilder: (_, index) {
                                            OrderItem item = listOrder[index];
                                            return Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Color.fromRGBO(
                                                              224, 224, 224, 1),
                                                          width: 1.0)),
                                                  color:
                                                  Color.fromRGBO(250, 250, 250, 1),
                                                ),
                                                width: double.infinity,
                                                height: 80,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 25),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10, horizontal: 5),
                                                child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 55,
                                                        height: 55,
                                                        margin:
                                                        EdgeInsets.only(right: 15),
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: NetworkImage("https://apos-server-kota202.et.r.appspot.com/manageMenu/photo?id_menu="+item.id_menu)
                                                          ),
                                                          color: Color.fromRGBO(
                                                              234, 234, 234, 1),
                                                          borderRadius:
                                                          BorderRadius.circular(20),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              Text(item.name_menu,
                                                                  style: TextStyle(
                                                                      color:
                                                                      Colors.black,
                                                                      fontSize: 16.0,
                                                                      fontFamily:
                                                                      'CircularStd-Bold')),
                                                              Text(
                                                                  "Rp " +
                                                                      FlutterMoneyFormatter(
                                                                          amount: double.parse(menus
                                                                              .firstWhere((menu) =>
                                                                          menu.id_menu ==
                                                                              item
                                                                                  .id_menu)
                                                                              .price
                                                                              .toString()))
                                                                          .output
                                                                          .withoutFractionDigits +
                                                                      " x " +
                                                                      item.quantity
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                      Colors.black,
                                                                      fontSize: 14.0,
                                                                      fontFamily:
                                                                      'CircularStd-Book'))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Container(
                                                              margin:
                                                              EdgeInsets.symmetric(
                                                                  vertical: 10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                                children: <Widget>[
                                                                  Text(
                                                                      "Rp " +
                                                                          FlutterMoneyFormatter(
                                                                              amount: double.parse((menus.firstWhere((menu) => menu.id_menu == item.id_menu).price * item.quantity)
                                                                                  .toString()))
                                                                              .output
                                                                              .withoutFractionDigits,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                          16.0,
                                                                          fontFamily:
                                                                          'CircularStd-Bold')),
                                                                ],
                                                              ))),
                                                    ]));
                                          }),
                                      checkout(
                                          menus, listOrder, currentState.totalPrice),
                                    ],
                                  ),
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            });
                      },
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
      ),
      );
  }

  Widget checkout(
      List<Menu> menus, List<OrderItem> listOrderItem, int totalPrice) {
    return Positioned(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoaded) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                                  (state.id_order != null)
                                      ? Text(
                                          "Tambahkan ke Pesanan",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontFamily: 'CircularStd-Bold'),
                                        )
                                      : Text(
                                          "Buat Pesanan",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontFamily: 'CircularStd-Bold'),
                                        )
                                ]),
                            onPressed: () async {
                              if (_formKey.currentState.validate()){
                                if (state.id_order != null) {
                                  await _onAddToOrderButtonPressed(
                                      state.id_order, listOrderItem, totalPrice);
                                } else {
                                  await _onCreateOrderButtonPressed(
                                      listOrderItem, totalPrice);
                                }
                              }
                            },
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
