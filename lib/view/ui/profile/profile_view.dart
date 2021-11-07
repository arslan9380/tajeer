import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/view/ui/profile/profile_viewmodel.dart';
import 'package:tajeer/view/widgets/item_widget.dart';
import 'package:tajeer/view/widgets/no_event_widget.dart';
import 'package:tajeer/view/widgets/profile_card.dart';
import 'package:tajeer/view/widgets/published_item_w_idget.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController _publishedScrollCon = ScrollController();
    ScrollController _hidesScrollCon = ScrollController();

    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, model, child) => Scaffold(
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: hMargin),
                child: DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                            pinned: false,
                            floating: false,
                            expandedHeight: 340 + vMargin,
                            collapsedHeight: 340,
                            backgroundColor: Colors.white,
                            automaticallyImplyLeading: false,
                            flexibleSpace: Container(
                                margin: EdgeInsets.symmetric(vertical: vMargin),
                                child: ProfileCard())),
                      ];
                    },
                    body: Column(
                      children: [
                        TabBar(
                          indicatorColor: Theme.of(context).primaryColor,
                          indicatorWeight: 4,
                          labelColor: Theme.of(context).primaryColor,
                          unselectedLabelColor: Theme.of(context).primaryColor,
                          unselectedLabelStyle: TextStyle(
                            fontSize: 20,
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          enableFeedback: false,
                          isScrollable: false,
                          labelStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          tabs: [
                            Tab(text: "Published"),
                            Tab(text: "Hide"),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Expanded(
                          child: TabBarView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                PublishedItemWidget(),
                                RawScrollbar(
                                  thumbColor: Theme.of(context).primaryColor,
                                  isAlwaysShown: true,
                                  controller: _hidesScrollCon,
                                  child: SingleChildScrollView(
                                    controller: _hidesScrollCon,
                                    physics: BouncingScrollPhysics(),
                                    child: model.hideItems.length == 0
                                        ? NoEventWidget(false)
                                        : ListView.builder(
                                            itemCount: 1,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.all(5),
                                            itemBuilder: (_, index) {
                                              return InkWell(
                                                  onTap: () {},
                                                  child: ItemWidget(
                                                    isFromHide: true,
                                                  ));
                                            }),
                                  ),
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
