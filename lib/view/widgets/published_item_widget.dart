import 'package:flutter/material.dart';
import 'package:tajeer/view/widgets/item_widget.dart';
import 'package:tajeer/view/widgets/no_event_widget.dart';

class PublishedItemWidget extends StatefulWidget {
  final int length;

  PublishedItemWidget({this.length = 1});

  @override
  _PublishedItemWidgetState createState() => _PublishedItemWidgetState();
}

class _PublishedItemWidgetState extends State<PublishedItemWidget> {
  ScrollController _publishedScrollCon = ScrollController();

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbColor: Theme.of(context).primaryColor,
      isAlwaysShown: true,
      controller: _publishedScrollCon,
      child: SingleChildScrollView(
        controller: _publishedScrollCon,
        physics: BouncingScrollPhysics(),
        child: widget.length == 0
            ? NoEventWidget(false)
            : ListView.builder(
                itemCount: 5,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(5),
                itemBuilder: (_, index) {
                  return InkWell(
                      onTap: () {},
                      child: ItemWidget(
                        isFromPublish: true,
                      ));
                }),
      ),
    );
  }
}
