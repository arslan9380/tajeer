import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tajeer/view/widgets/round_image.dart';

class MsgReceiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundImage(
              radius: Get.width * 0.12,
            ),
            SizedBox(
              width: 6,
            ),
            Container(
              width: Get.width * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(20),
                ),
                color: Color(0xffeff3fd),
              ),
              padding: const EdgeInsets.only(
                right: 9,
                left: 9,
                top: 13,
                bottom: 15,
              ),
              child: Text(
                "Right away! Are you free today for a quich catch up",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
