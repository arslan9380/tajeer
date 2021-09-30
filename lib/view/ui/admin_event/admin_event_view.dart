import 'package:event_app/app/constants.dart';
import 'package:event_app/models/blog_model.dart';
import 'package:event_app/view/ui/admin_event/admin_event_viewmodel.dart';
import 'package:event_app/view/widgets/event_tab_bar.dart';
import 'package:event_app/view/widgets/event_tile.dart';
import 'package:event_app/view/widgets/inputfield_widget.dart';
import 'package:event_app/view/widgets/no_event_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AdminEventView extends StatefulWidget {
  @override
  _AdminEventViewState createState() => _AdminEventViewState();
}

class _AdminEventViewState extends State<AdminEventView> {
  TextEditingController searchCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminEventViewModel>.reactive(
        viewModelBuilder: () => AdminEventViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: hMargin, vertical: vMargin),
                  child: Column(
                    children: [
                      InputFieldWidget(
                        controller: searchCon,
                        prefixIcon: Icons.search,
                        hint: "Search Event by Title",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      EventTabBar(model),
                      SizedBox(
                        height: 10,
                      ),
                      IndexedStack(
                        index: model.currentIndex,
                        children: [
                          ListView.builder(
                            itemCount: 6,
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
                          NoEventWidget(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
