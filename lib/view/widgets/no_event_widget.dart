import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoEventWidget extends StatelessWidget {
  final bool isFromCompleted;
  final String title;

  NoEventWidget(this.isFromCompleted, {this.title = "Sorry! No Item yet"});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: Get.height * 0.12,
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
            child: Image.asset("assets/empty.jfif")),
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 24,
            fontFamily: "SF Pro Rounded",
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
