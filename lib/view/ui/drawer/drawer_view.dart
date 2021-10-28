import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({Key key}) : super(key: key);

  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.27,
              color: Colors.red),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06,
                vertical: MediaQuery.of(context).size.height * 0.03),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Image.asset(
                        "assets/menu.png",
                        color: Color.fromRGBO(255, 255, 255, 1),
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/logo.png",
                      height: MediaQuery.of(context).size.width * 0.2,
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                  ),
                ]),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.22,
            top: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.01),
                          child: Icon(
                            Icons.person_pin,
                            color: Colors.white,
                          )),
                      height: MediaQuery.of(context).size.width * 0.1,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          border: Border.all(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 12,
                          color: Colors.red),
                    ),
                  )
                ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.01),
                          child: Icon(
                            Icons.list_alt_outlined,
                            color: Colors.white,
                          )),
                      height: MediaQuery.of(context).size.width * 0.1,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          border: Border.all(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Bill Details",
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 12,
                          color: Colors.red),
                    ),
                  )
                ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.01),
                          child: Icon(
                            Icons.chat,
                            color: Colors.white,
                          )),
                      height: MediaQuery.of(context).size.width * 0.1,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          border: Border.all(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Messages",
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 12,
                          color: Colors.red),
                    ),
                  )
                ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.01),
                          child: Icon(
                            Icons.notification_important,
                            color: Colors.white,
                          )),
                      height: MediaQuery.of(context).size.width * 0.1,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          border: Border.all(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Notifications",
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 12,
                          color: Colors.red),
                    ),
                  )
                ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            ),
          ),
        ],
        clipBehavior: Clip.none,
        // overflow: Overflow.visible,
      ),
    );
  }
}
