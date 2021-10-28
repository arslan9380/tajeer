import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/view/widgets/event_tile.dart';
import 'package:tajeer/view/widgets/inputfield_widget.dart';
import 'package:tajeer/view/widgets/no_event_widget.dart';

import 'event_viewmodel.dart';

class EventView extends StatefulWidget {
  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  TextEditingController searchCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventViewModel>.reactive(
      viewModelBuilder: () => locator<EventViewModel>(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: model.loading
            ? Center(child: CircularProgressIndicator())
            : ModalProgressHUD(
                inAsyncCall: model.isProcessing,
                child: SingleChildScrollView(
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
                          onChange: model.onFilter,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        IndexedStack(
                          index: model.currentIndex,
                          children: [
                            model.upcomingFiltered.length == 0
                                ? NoEventWidget(false)
                                : ListView.builder(
                                    itemCount: model.upcomingFiltered.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) {
                                      return EventTile(
                                        eventModel:
                                            model.upcomingFiltered[index],
                                        onDelete: () {
                                          model.deleteEvent(
                                              model.upcomingFiltered[index]);
                                        },
                                      );
                                    },
                                  ),
                            model.completedFiltered.length == 0
                                ? NoEventWidget(true)
                                : ListView.builder(
                                    itemCount: model.completedFiltered.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) {
                                      return EventTile(
                                          eventModel:
                                              model.completedFiltered[index]);
                                    },
                                  ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.initialise()),
    );
  }
}
