import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoEventWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: Get.height * 0.07,
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
            child: Image.asset(
              "assets/no_event.png",
            )),
        SizedBox(
          height: 10,
        ),
        Text(
          "No Completed Events",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 24,
            fontFamily: "SF Pro Rounded",
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
