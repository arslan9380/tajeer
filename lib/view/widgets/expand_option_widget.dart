import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpandOptionWidget extends StatelessWidget {
  final String title;
  final String selectedValue;
  final bool isLastItem;

  ExpandOptionWidget({this.title, this.selectedValue, this.isLastItem = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: title != selectedValue
                ? Colors.transparent
                : Theme.of(context).primaryColor,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          margin: EdgeInsets.only(top: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: title == selectedValue
                  ? Colors.white
                  : Theme.of(context).primaryColor,
            ),
            textAlign: TextAlign.left,
          ),
        ),

        // !isLastItem
        //     ? Container(
        //         height: 1,
        //         color: Theme.of(context).accentColor,
        //       )
        //     : SizedBox(
        //         height: 10,
        //         width: Get.width,
        //       )
      ],
    );
  }
}
