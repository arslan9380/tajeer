import 'package:event_app/app/constants.dart';
import 'package:event_app/app/locator.dart';
import 'package:event_app/view/ui/calender/calender_viewmodel.dart';
import 'package:event_app/view/widgets/calender_widget.dart';
import 'package:event_app/view/widgets/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class CalenderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalenderViewModel>.reactive(
      viewModelBuilder: () => locator<CalenderViewModel>(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin:
                EdgeInsets.symmetric(horizontal: hMargin, vertical: vMargin),
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
                          color: Theme.of(context).primaryColor, fontSize: 18),
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
                model.eventOnDate.length == 0
                    ? Container(
                        height: 100,
                        child: Center(child: Text("No Event On This Date")))
                    : ListView.builder(
                        itemCount: model.eventOnDate.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return EventTile(
                            eventModel: model.eventOnDate[index],
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: false,
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.initialise()),
    );
  }
}
