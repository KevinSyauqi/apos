import 'package:flutter/material.dart';

class TransaksiMenu extends StatefulWidget {
  _TransaksiMenuState createState() => _TransaksiMenuState();
}

class _TransaksiMenuState extends State<TransaksiMenu>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final List<Map> menuLists = [
    {
      "name": "Nama Menu",
      "price": "Rp 5.000",
    },
    {
      "name": "Nama Menu",
      "price": "Rp 5.000",
    },
    {
      "name": "Nama Menu",
      "price": "Rp 5.000",
    },
    {
      "name": "Nama Menu",
      "price": "Rp 5.000",
    },
    {
      "name": "Nama Menu",
      "price": "Rp 5.000",
    },
    {
      "name": "Nama Menu ",
      "price": "Rp 5.000",
    },
    {
      "name": "Nama Menu",
      "price": "Rp 5.000",
    },
    {
      "name": "Nama Menu 1",
      "price": "Rp 5.000",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 250, 252, 1),
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
          drawer: Drawer(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 90),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: menuLists.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildList(context, index);
                      }),
                ),
                checkOut(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildList(BuildContext context, int index) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(menuLists[index]['name'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: 'CircularStd-Bold')),
                Text(menuLists[index]['price'],
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
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                    child: Text('0',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontFamily: 'CircularStd-Bold')),
                  ),
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
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget checkOut() {
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
                width: MediaQuery.of(context).size.width / 1.35,
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
                    child: Row(children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "2 pesanan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: 'CircularStd-Book'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                      ),
                      Text(
                        "Rp 10.000",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'CircularStd-Bold'),
                      ),
                    ]),
                    onPressed: () {},
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(54, 58, 155, 1),
                    borderRadius: BorderRadius.circular(19)),
                child: IconButton(
                  icon: Icon(Icons.view_list),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
