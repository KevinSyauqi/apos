import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/ui/History/history_detail.dart';
import 'package:apos/src/ui/ManageOrder/checkout_order_page.dart';
import 'package:apos/src/ui/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class ListOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActiveOrderBloc(),
      child: ListOrder(),
    );
  }
}

class ListOrder extends StatefulWidget {
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  ActiveOrderBloc _activeOrderBloc;

  @override
  void initState() {
    _activeOrderBloc = BlocProvider.of<ActiveOrderBloc>(context);
    _activeOrderBloc.add(fetchListOrder());
  }

  @override
  void dispose() {
    super.dispose();
    _activeOrderBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Daftar Pesanan",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'CircularStd-Bold'),
            ),
            bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                  )
                ],
              ),
              preferredSize: Size(0, 50),
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
          body: BlocBuilder<ActiveOrderBloc, ActiveOrderState>(
            builder: (context, state) {
              if (state is ActiveOrderLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ActiveOrderLoaded) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      ListView.builder(
                          itemCount: state.listOrder.listOrder.length,
                          itemBuilder: (_, index) {
                            Order order = state.listOrder.listOrder[index];
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
                                      Expanded(
                                        child: Container(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => CheckoutOrderPage(
                                                        id_order:
                                                        order.id_order),
                                                  )).then((value) {
                                                if (value) {
                                                  _activeOrderBloc.add(fetchListOrder());
                                                }
                                              });
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                    "No #" +
                                                        order.id_order
                                                            .substring(0, 6) +
                                                        order.id_order
                                                            .substring(15, 18),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        fontFamily:
                                                            'CircularStd-Bold')),
                                                Text(
                                                    DateFormat('EEE, d MMMM '
                                                            'yyyy')
                                                        .format(order.date),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.0,
                                                        fontFamily:
                                                            'CircularStd-Book')),
                                                order.customer_name != null
                                                    ? Text("Nomor Meja : ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'CircularStd-Bold'))
                                                    : Text(order.customer_name),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                                                              child: Center(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            height: 40,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color:
                                                    Color.fromRGBO(54, 58, 155, 1),
                                                borderRadius:
                                                    BorderRadius.circular(13)),
                                            child: Text("Tambah Pesanan",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.0,
                                                    fontFamily:
                                                        'CircularStd-Bold')),
                                          ),
                                        ),
                                        onTap: (){},
                                      )
                                    ]));
                          })
                    ],
                  ),
                );
              }
              return Center(child: Text("History Empty"));
            },
          ),
        ),
      ]),
    );
  }
}

class Outlet {
  String name;

  Outlet(this.name);
}
