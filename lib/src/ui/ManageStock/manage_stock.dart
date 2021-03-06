import 'dart:convert';

import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageStockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageStockBloc>(
          create: (context) => ManageStockBloc(),
        ),
        BlocProvider<PredictionBloc>(
          create: (context) => PredictionBloc(),
        ),
        BlocProvider<StockBloc>(
          create: (context) => StockBloc(),
        ),
      ],
      child: ManageStock(),
    );
  }
}

class ManageStock extends StatefulWidget {
  _ManageStockState createState() => _ManageStockState();
}

class _ManageStockState extends State<ManageStock>
    with SingleTickerProviderStateMixin {
  PredictionBloc _predictionBloc;
  ManageStockBloc _manageStockBloc;
  StockBloc _stockBloc;
  TabController controller;
  TextEditingController addStockController = TextEditingController();
  TextEditingController removeStockController = TextEditingController();

  final _formAddKey = GlobalKey<FormState>();
  final _formRemoveKey = GlobalKey<FormState>();

  _onAddStockPressed(String id_menu) async {
    await _stockBloc.add(AddStock(
        id_menu: id_menu, quantity_stock: int.parse(addStockController.text)));
  }

  _onRemoveStockPressed(String id_menu) async {
    await _stockBloc.add(RemoveStock(
        id_menu: id_menu,
        quantity_stock: int.parse(removeStockController.text)));
  }

  @override
  void initState() {
    _manageStockBloc = BlocProvider.of<ManageStockBloc>(context);
    _manageStockBloc.add(FetchingAllStock());
    _stockBloc = BlocProvider.of<StockBloc>(context);
    controller = TabController(length: 2, vsync: this);
    super.initState();
    _predictionBloc = BlocProvider.of<PredictionBloc>(context);
    _predictionBloc.add(GetDetailStockPrediction());
  }

  @override
  void dispose() {
    controller.dispose();
    _manageStockBloc.close();
    _predictionBloc.close();
    _stockBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockBloc, StockState>(builder: (context, state) {
      if (state is AddStockSuccess) {
        _manageStockBloc.add(FetchingAllStock());
        _stockBloc.add(ReloadStock());
        addStockController = TextEditingController();
      }
      if (state is RemoveStockSuccess) {
        _manageStockBloc.add(FetchingAllStock());
        _stockBloc.add(ReloadStock());
        removeStockController = TextEditingController();
      }
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
                  BlocBuilder<PredictionBloc,PredictionState>(
                    builder: (context,state){
                      if(state is PredictionDetailLoaded){
                        List<Prediction> listPredictions = state.listPrediction;
                        return BlocBuilder<ManageStockBloc, ManageStockState>(
                            builder: (context, state) {
                              if (state is ManageStockLoaded) {
                                imageCache.clearLiveImages();
                                return TabBarView(
                                  controller: controller,
                                  children: <Widget>[
                                    getListMenu(state.foods, listPredictions),
                                    getListMenu(state.drinks, listPredictions)
                                  ],
                                );
                              }
                              if (state is ManageStockEmpty) {
                                return Center(child: Text("Belum ada menu nih"));
                              }
                              if (state is ManageStockLoading) {
                                return Center(child: CircularProgressIndicator());
                              }
                              if (state is ManageStockError) {
                                return Center(child: Text('error'));
                              }
                              return Center(child: Text("t"));
                            });
                      }
                      return Center();
                    },
                  ),
                ],
              ),
            ),
          ),
        ]),
      );
    });
  }

  Widget getListMenu(List<Menu> menus, List<Prediction> listPredictions) {
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          itemCount: menus.length,
          itemBuilder: (BuildContext context, int index) {
            Menu menu = menus[index];
            Prediction prediction;
            listPredictions.forEach((element) {
              if(element.id_menu == menu.id_menu){
                prediction = element;
              }
            });
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
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage("https://apos-server-kota202.et.r.appspot.com/manageMenu/photo?id_menu="+menu.id_menu)
                      ),
                      color: Color.fromRGBO(234, 234, 234, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Container(
                    width: 200,
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
                          Text("Stok :  ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'CircularStd-Book')),
                          Text(menu.quantity_stock.toString() + " pcs",
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
                              icon: Icon(Icons.add),
                              iconSize: 17,
                              color: Colors.white,
                              onPressed: () {
                                if(prediction != null){
                                  _showAddStock(menu.id_menu, prediction.wma);
                                }
                                else _showAddStock(menu.id_menu, null);
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
                              icon: Icon(Icons.remove),
                              iconSize: 17,
                              color: Colors.white,
                              onPressed: () {
                                _showRemoveStock(menu.id_menu);
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
          }),
    );
  }

  void _showRemoveStock(String id_menu) {
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
              Form(
                key: _formRemoveKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  height: 100,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                  child: TextFormField(
                    controller: removeStockController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Jumlah tidak boleh kosong";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.numberWithOptions(),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      hintText: "Kurangi Berapa Stok",
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontFamily: 'CircularStd-Book'),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 40),
                            color: Color.fromRGBO(54, 58, 155, 1),
                            elevation: 5,
                            onPressed: () async {
                              if (_formRemoveKey.currentState.validate()) {
                                await _onRemoveStockPressed(id_menu);
                                await Future.delayed(Duration(seconds: 1));
                                removeStockController.clear();
                                Navigator.pop(context);
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0))),
                            child: Text("Simpan",
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                        SizedBox(width: 10),
                        RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 40),
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
                ),
              )
            ],
          );
        });
  }

  void _showAddStock(String id_menu, int stock_prediction) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text("Penambahan Stok ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'CircularStd-Bold')),
            actions: <Widget>[
              Center(
                child: Text(
                    "Prediksi Stok : " +
                        ((stock_prediction != null)
                            ? stock_prediction.toString()
                            : "Tidak tersedia"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'CircularStd-Book')),
              ),
              SizedBox(height: 10),
              Form(
                key: _formAddKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  height: 100,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Jumlah tidak boleh kosong";
                      }
                      return null;
                    },
                    controller: addStockController,
                    keyboardType: TextInputType.numberWithOptions(),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      hintText: "Tambah Berapa Stok",
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontFamily: 'CircularStd-Book'),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 40),
                            color: Color.fromRGBO(54, 58, 155, 1),
                            elevation: 5,
                            onPressed: () async {
                              if (_formAddKey.currentState.validate()) {
                                await _onAddStockPressed(id_menu);
                                await Future.delayed(Duration(seconds: 1));
                                addStockController.clear();
                                Navigator.pop(context);
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0))),
                            child: Text("Simpan",
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                        SizedBox(width: 10),
                        RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 40),
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
                ),
              )
            ],
          );
        });
  }
}
