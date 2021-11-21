import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/models/offer_model.dart';
import 'package:tajeer/view/ui/offers/offers_viewmodel.dart';
import 'package:tajeer/view/widgets/offer_widget.dart';

class OffersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OffersViewModel>.reactive(
        viewModelBuilder: () => OffersViewModel(),
        onModelReady: (model) => SchedulerBinding.instance
            .addPostFrameCallback((_) => model.getOffers()),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "Offers",
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
                      : Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: hMargin, vertical: vMargin),
                          child: Column(
                            children: [
                              Center(
                                child: CupertinoSegmentedControl<int>(
                                  selectedColor: Theme.of(context).primaryColor,
                                  borderColor: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  children: <int, Widget>{
                                    0: Text("Pending"),
                                    1: Text("Accepted"),
                                    2: Text("   Rejected   "),
                                  },
                                  onValueChanged: model.updateSegment,
                                  groupValue: model.currentSegment,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: model.currentSegment == 0
                                        ? model.myPendingOffers.length
                                        : model.currentSegment == 1
                                            ? model.myAcceptedOffers.length
                                            : model.myRejectedOffers.length,
                                    itemBuilder: (_, index) {
                                      OfferModel offer = model.currentSegment ==
                                              0
                                          ? model.myPendingOffers[index]
                                          : model.currentSegment == 1
                                              ? model.myAcceptedOffers[index]
                                              : model.myRejectedOffers[index];

                                      return OfferWidget(
                                        offer: offer,
                                        model: model,
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
            ));
  }
}
