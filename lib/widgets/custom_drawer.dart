import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key, required this.fun});
  final Function fun;

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ListTile(
              title: Text('Mes Favoris',
                  style: TextStyle(color: Colors.purple[400])),
              onTap: () {
                Scaffold.of(context).closeEndDrawer();
              },
            ),
            ListTile(
              title: Text('Le top'),
              onTap: () {
                Scaffold.of(context).closeEndDrawer();
              },
            ),
            ListTile(
              title: Text('Coming Soon'),
              onTap: () {
                Scaffold.of(context).closeEndDrawer();
              },
            ),
          ],
        ),
      ),
    );
  }
}
