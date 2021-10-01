import 'package:event_app/app/constants.dart';
import 'package:event_app/models/blog_model.dart';
import 'package:event_app/view/ui/calender/calender_viewmodel.dart';
import 'package:event_app/view/widgets/calender_widget.dart';
import 'package:event_app/view/widgets/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class CalenderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalenderViewModel>.reactive(
        viewModelBuilder: () => CalenderViewModel(),
        builder: (context, model, child) => Scaffold(
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: hMargin, vertical: vMargin),
                  child: Column(
                    children: [
                      CalenderWidget(model),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            DateFormat("E d-MMM-y").format(model.selectedDate),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).primaryColor,
                              height: 2,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return EventTile(
                            blogModel: BlogModel(
                                title: "Christmas Event",
                                id: "",
                                body: "",
                                image:
                                    "https://www.edarabia.com/wp-content/uploads/2018/06/certificate-events-uae-191302.jpg",
                                timeOfBlog: DateTime.now()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
