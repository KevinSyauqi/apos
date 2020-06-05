import 'package:flutter/material.dart';

class MenuMinum extends StatefulWidget {
  @override
  _MenuMinumState createState() => _MenuMinumState();
}

final List<Map> menuLists = [
  {
    "name": "Nama Minum",
    "price": "Rp 5.000",
  },
  {
    "name": "Nama Minum",
    "price": "Rp 5.000",
  },
  {
    "name": "Nama Minum",
    "price": "Rp 5.000",
  },
  {
    "name": "Nama Minum",
    "price": "Rp 5.000",
  },
  {
    "name": "Nama Minum",
    "price": "Rp 5.000",
  },
  {
    "name": "Nama Minum ",
    "price": "Rp 5.000",
  },
  {
    "name": "Nama Minum",
    "price": "Rp 5.000",
  },
  {
    "name": "Nama Minum",
    "price": "Rp 5.000",
  },
];

class _MenuMinumState extends State<MenuMinum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 90),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: ListView.builder(
          itemCount: menuLists.length,
          itemBuilder: (BuildContext context, int index) {
            return buildList(context, index);
          }),
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
}
