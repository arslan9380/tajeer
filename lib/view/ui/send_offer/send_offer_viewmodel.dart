import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/app/static_info.dart';
import 'package:tajeer/models/chat.dart';
import 'package:tajeer/models/item_model.dart';
import 'package:tajeer/models/offer_model.dart';
import 'package:tajeer/models/user_model.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/services/offer_service.dart';

class SendOfferViewModel extends BaseViewModel {
  DateTime fromDate;
  DateTime toDate;
  CommonUiService commonUiService = locator<CommonUiService>();
  OfferService offerService = locator<OfferService>();
  bool procesing = false;

  setProcessing(bool val) {
    procesing = val;
    notifyListeners();
  }

  Future<void> sendOffer(
      ItemModel itemModel, Chat chatModel, String rent, String note) async {
    print(itemModel);
    print(rent);
    if (itemModel == null || rent.isEmpty || note.isEmpty) {
      commonUiService.showSnackBar("Please fill all the fields");
      return;
    }

    setProcessing(true);
    UserModel renterModel = UserModel(
      id: chatModel.uid,
      fistName: chatModel.name,
      image: chatModel.imageUrl,
    );

    OfferModel offerModel = OfferModel(
        ownerModel: StaticInfo.userModel,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        renterModel: renterModel,
        startDate: Timestamp.fromDate(fromDate),
        endDate: Timestamp.fromDate(toDate),
        item: itemModel,
        rentPerDay: rent,
        sendById: StaticInfo.userModel.id,
        sendToId: chatModel.uid,
        note: note,
        status: pendingOffer);

    await offerService.addOffer(offerModel);
    setProcessing(false);
    Get.back();
    commonUiService.showSnackBar("Offer Sent Successfully");
  }
}
