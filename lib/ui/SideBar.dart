import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(
        child: new ListView(
          children: <Widget> [
            new DrawerHeader(child: new Text('Header'),),
            new ListTile(
              title: new Text('First Menu Item'),
              onTap: () {},
            ),
            new ListTile(
              title: new Text('Second Menu Item'),
              onTap: () {},
            ),
            new Divider(),
            new ListTile(
              title: new Text('About'),
              onTap: () {},
            ),
          ],
        )
      ),
    );
  }
}