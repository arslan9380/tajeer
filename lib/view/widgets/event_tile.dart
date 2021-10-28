import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tajeer/models/event_model.dart';
import 'package:tajeer/view/widgets/rect_image.dart';

class EventTile extends StatelessWidget {
  final EventModel eventModel;
  final Function onDelete;
  final bool isJoined;

  EventTile({this.eventModel, this.onDelete, this.isJoined = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(18)),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Hero(
                      tag: eventModel.id,
                      child: RectImage(
                        imageUrl: eventModel.image,
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    eventModel.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  DateFormat("d-MMM-y").format(eventModel.startTime.toDate()),
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    "Joining Fee",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  eventModel.price + " USD",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}
