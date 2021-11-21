import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/models/offer_model.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/services/offer_service.dart';
import 'package:tajeer/services/rating_service.dart';

class PastOwnersViewModel extends BaseViewModel with CommonUiService {
  String msg = "";
  bool loading = true;
  OfferService offerService = locator<OfferService>();
  RatingService ratingService = locator<RatingService>();
  List<OfferModel> myAcceptedOffers = [];
  bool processing = false;

  setProcessing(bool val) {
    processing = val;
    notifyListeners();
  }

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  getOffers() async {
    var response = await offerService.getMyPastOwners();
    setLoading(false);
    if (response != false) {
      myAcceptedOffers = response;
    } else {
      msg = "We're facing some problem\nPlease try again later";
    }
  }

  rateRenter(double rating, OfferModel offer) async {
    if (offer.renterModel.rating != null) {
      showSnackBar("Updating a rating isn't allowed");
      return;
    }

    setProcessing(true);
    await offerService.saveRatingInOfferOwner(offer, rating);
    await ratingService.addRating(rating, offer.ownerModel.id);
    setProcessing(false);
  }
}
