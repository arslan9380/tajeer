import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;

  DrawerItem({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
            child: Icon(
              icon,
              color: Colors.white,
            )),
        height: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.1,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            border: Border.all(color: Colors.white)),
      ),
      SizedBox(
        width: 15,
      ),
      Text(
        title,
        style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor),
      )
    ]);
  }
}
