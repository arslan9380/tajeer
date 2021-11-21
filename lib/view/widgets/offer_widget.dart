import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/models/offer_model.dart';
import 'package:tajeer/view/ui/offers/offers_viewmodel.dart';
import 'package:tajeer/view/widgets/item_widget.dart';

class OfferWidget extends StatelessWidget {
  final OfferModel offer;
  final OffersViewModel model;

  OfferWidget({this.offer, this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ItemWidget(
            itemModel: offer.item,
          ),
          Row(
            children: [
              Text("Final Rent per day: "),
              Text("\$" + offer.rentPerDay),
            ],
          ),
          Row(
            children: [
              Text("Duration: "),
              Text(DateFormat("d-MM-y").format(offer.startDate.toDate()) +
                  " to " +
                  DateFormat("d-MM-y").format(offer.endDate.toDate())),
            ],
          ),
          Row(
            children: [
              Text("Amount to be Paid: "),
              Text("\$" +
                  (((offer.endDate
                                  .toDate()
                                  .difference(offer.startDate.toDate())
                                  .inDays) +
                              1) *
                          int.parse(offer.rentPerDay))
                      .toString()),
            ],
          ),
          Container(
            width: Get.width,
            child: ReadMoreText(
              offer.note,
              textAlign: TextAlign.left,
              trimLines: 1,
              delimiter: "...",
              colorClickableText: Theme.of(context).primaryColor,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Read More',
              trimExpandedText: 'Show less',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          if (offer.status == pendingOffer)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    model.acceptOffer(offer);
                  },
                  child: Container(
                    width: Get.width * 0.3,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.50),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "Accept",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.28,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    model.rejectOffer(offer);
                  },
                  child: Container(
                    width: Get.width * 0.3,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.50),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "Reject",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.28,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
