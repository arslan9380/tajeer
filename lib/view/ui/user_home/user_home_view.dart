import 'package:event_app/view/ui/calender/calander_view.dart';
import 'package:event_app/view/ui/event/event_view.dart';
import 'package:event_app/view/ui/user_home/user_home_viewmodel.dart';
import 'package:event_app/view/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class UserHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserHomeViewModel>.reactive(
        viewModelBuilder: () => UserHomeViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "What's the Move",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontFamily: GoogleFonts.acme().fontFamily,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: IndexedStack(
                index: model.currentIndex,
                children: [EventView(), CalenderView()],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0.0,
                child: Icon(
                  Icons.event_available,
                  size: 23,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
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
