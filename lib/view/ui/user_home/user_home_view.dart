import 'package:tajeer/view/ui/drawer/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/view/ui/add_event/add_event_view.dart';
import 'package:tajeer/view/ui/event/event_view.dart';
import 'package:tajeer/view/ui/user_home/user_home_viewmodel.dart';
import 'package:tajeer/view/widgets/bottom_nav_bar.dart';

class UserHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserHomeViewModel>.reactive(
        viewModelBuilder: () => UserHomeViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "TAJEER",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontFamily: GoogleFonts.acme().fontFamily,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                actions: [
                  InkWell(
                      onTap: () {
                        model.logout();
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(Icons.logout)))
                ],
              ),
              drawer: DrawerView(),
              body: IndexedStack(
                index: model.currentIndex,
                children: [EventView()],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.to(() => AddEventView());
                },
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0.0,
                child: Icon(
                  Icons.event_available,
                  size: 23,
                ),
              ),
              extendBody: true,
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: BottomNavBar(
                selectedIndex: model.currentIndex,
                onIndexChange: (index) {
                  model.setIndex(index);
                },
              ),
            ));
  }
}
