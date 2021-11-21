import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/models/offer_model.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/services/offer_service.dart';

class OffersViewModel extends BaseViewModel with CommonUiService {
  List<OfferModel> myAllOffers = [];
  List<OfferModel> myPendingOffers = [];
  List<OfferModel> myAcceptedOffers = [];
  List<OfferModel> myRejectedOffers = [];
  int currentSegment = 0;

  OfferService offerService = locator<OfferService>();
  bool loading = true;
  String msg = "";

  setLaoding(bool val) {
    loading = val;
    notifyListeners();
  }

  getOffers() async {
    var response = await offerService.getMyOffers();
    setLaoding(false);

    if (response != false) {
      myAllOffers = response;
      myAcceptedOffers = myAllOffers
          .where((element) => element.status == acceptedOffer)
          .toList();
      print(myAcceptedOffers.length);
      myRejectedOffers = myAllOffers
          .where((element) => element.status == rejectedOffer)
          .toList();
      print(myAcceptedOffers.length);
      myPendingOffers = myAllOffers
          .where((element) => element.status == pendingOffer)
          .toList();
      print(myAcceptedOffers.length);
    } else {
      msg = "We're facing some problem\nPlease try again later";
    }
  }

  void updateSegment(int value) {
    currentSegment = value;
    notifyListeners();
  }

  acceptOffer(OfferModel offer) {
    myPendingOffers.removeWhere((element) => element.id == offer.id);
    offer.status = acceptedOffer;
    myAcceptedOffers.add(offer);
    offerService.acceptOffer(offer);
    notifyListeners();
    showSnackBar("Offer accepted Sucessfully");
  }

  rejectOffer(OfferModel offer) {
    myPendingOffers.removeWhere((element) => element.id == offer.id);
    offer.status = rejectedOffer;
    myRejectedOffers.add(offer);
    offerService.rejectOffer(offer);
    notifyListeners();
    showSnackBar("You've rejected the offer");
  }
}
