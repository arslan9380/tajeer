import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/view/ui/past_renters/past_renters_viewmodel.dart';
import 'package:tajeer/view/widgets/past_renter_widget.dart';

class PastRentersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PastRentersViewModel>.reactive(
        viewModelBuilder: () => PastRentersViewModel(),
        onModelReady: (model) => SchedulerBinding.instance
            .addPostFrameCallback((_) => model.getOffers()),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "Past Renters",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: model.loading
                  ? Center(child: CircularProgressIndicator())
                  : model.msg != ""
                      ? Center(
                          child: Text(
                          model.msg,
                          textAlign: TextAlign.center,
                        ))
                      : model.myAcceptedOffers.length == 0
                          ? Center(
                              child:
                                  Text(" You haven't give anything on rent."))
                          : ModalProgressHUD(
                              inAsyncCall: model.processing,
                              child: SingleChildScrollView(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: hMargin, vertical: vMargin),
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                          itemCount:
                                              model.myAcceptedOffers.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (_, index) {
                                            return PastRenterWidget(
                                              model: model,
                                              offer:
                                                  model.myAcceptedOffers[index],
                                            );
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            ),
            ));
  }
}
