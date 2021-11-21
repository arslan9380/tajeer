import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tajeer/models/offer_model.dart';
import 'package:tajeer/view/ui/past_owners/past_owners_viewmodel.dart';
import 'package:tajeer/view/ui/profile/profile_view.dart';
import 'package:tajeer/view/widgets/filled_button.dart';
import 'package:tajeer/view/widgets/item_widget.dart';

class PastOwnerWidget extends StatelessWidget {
  final OfferModel offer;
  final PastOwnersViewModel model;

  PastOwnerWidget({this.offer, this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        ItemWidget(
          itemModel: offer.item,
        ),
        Row(
          children: [
            Text("Owner Name: "),
            Text(offer.ownerModel.fistName),
          ],
        ),
        Row(
          children: [
            Text("Rented for: "),
            Text(DateFormat("d-MM-y").format(offer.startDate.toDate()) +
                " to " +
                DateFormat("d-MM-y").format(offer.endDate.toDate())),
          ],
        ),
        Row(
          children: [
            Text("Amount Paid: "),
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
        SizedBox(
          height: 8,
        ),
        RatingBar.builder(
          initialRating: offer.ownerModel.rating == null
              ? 0
              : double.parse(offer.ownerModel.rating),
          minRating: 1,
          glow: true,
          ignoreGestures: offer.ownerModel.rating == null ? false : true,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            model.rateRenter(rating, offer);
          },
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            Get.to(ProfileView(
              userId: offer.ownerModel.id,
            ));
          },
          child: FilledButton(
            title: "View Profile",
          ),
        )
      ]),
    );
  }
}
