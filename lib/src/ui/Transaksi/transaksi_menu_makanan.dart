import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuMakan extends StatefulWidget {
  @override
  _MenuMakanState createState() => _MenuMakanState();
}

class _MenuMakanState extends State<MenuMakan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 90),
      child: BlocBuilder(
        bloc: BlocProvider.of<MenuBloc>(context),
        builder: (context, state) {
          if (state is MenuInitialized) {
            return Center(child: Text("Unitialized State"));
          } else if (state is MenuEmpty) {
            return Center(child: Text("Belum ada menu nih"));
          } else if (state is MenuLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MenuError){
            return Center(child: Text('error'));
          }
          final menuLoaded = state as MenuLoaded;
          final menus = menuLoaded.menus;
          return buildMenuList(menus);
        },
      ),
    );
  }
}

Widget buildMenuList(List<Menu> menus) {
  return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      itemCount: menus.length,
      itemBuilder: (BuildContext context, int index) {
        Menu menu = menus[index];
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
      });
}