import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/app/static_info.dart';
import 'package:tajeer/models/offer_model.dart';

@singleton
class OfferService {
  String _offersKey = "offers";

  Future addOffer(OfferModel offerModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(_offersKey)
          .doc(offerModel.id)
          .set(offerModel.toMap(), SetOptions(merge: true));
      return offerModel;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future acceptOffer(OfferModel offerModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(_offersKey)
          .doc(offerModel.id)
          .set({"status": acceptedOffer}, SetOptions(merge: true));
      return offerModel;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future rejectOffer(OfferModel offerModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(_offersKey)
          .doc(offerModel.id)
          .set({"status": rejectedOffer}, SetOptions(merge: true));
      return offerModel;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future getMyOffers() async {
    List<OfferModel> myAllOffers = [];
    try {
      var result = await FirebaseFirestore.instance
          .collection(_offersKey)
          .where("sendToId", isEqualTo: StaticInfo.userModel.id)
          .get();
      for (var doc in result.docs) {
        myAllOffers.add(OfferModel.fromMap(doc.data()));
      }
      return myAllOffers;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  ///----------------------------------------

  Future getMyPastRenters() async {
    List<OfferModel> myAllOffers = [];
    try {
      var result = await FirebaseFirestore.instance
          .collection(_offersKey)
          .where("sendById", isEqualTo: StaticInfo.userModel.id)
          .where("status", isEqualTo: acceptedOffer)
          .get();
      for (var doc in result.docs) {
        myAllOffers.add(OfferModel.fromMap(doc.data()));
      }
      return myAllOffers;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future getMyPastOwners() async {
    List<OfferModel> myAllOffers = [];
    try {
      var result = await FirebaseFirestore.instance
          .collection(_offersKey)
          .where("sendToId", isEqualTo: StaticInfo.userModel.id)
          .where("status", isEqualTo: acceptedOffer)
          .get();
      for (var doc in result.docs) {
        myAllOffers.add(OfferModel.fromMap(doc.data()));
      }
      return myAllOffers;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future saveRatingInOfferOwner(OfferModel offerModel, double rating) async {
    try {
      offerModel.ownerModel.rating = rating.toString();
      await FirebaseFirestore.instance
          .collection(_offersKey)
          .doc(offerModel.id)
          .set({"ownerModel": offerModel.ownerModel.toMap()},
              SetOptions(merge: true));
      return offerModel;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future saveRatingInOfferRenter(OfferModel offerModel, double rating) async {
    try {
      offerModel.renterModel.rating = rating.toString();
      await FirebaseFirestore.instance
          .collection(_offersKey)
          .doc(offerModel.id)
          .set({"renterModel": offerModel.renterModel.toMap()},
              SetOptions(merge: true));
      return offerModel;
    } catch (e) {
      print(e);
      return false;
    }
  }

//
// Future deleteItem(WishlistModel wishlistModel) async {
//   try {
//     await FirebaseFirestore.instance
//         .collection(_wishlistKey)
//         .doc(wishlistModel.id)
//         .delete();
//     return wishlistModel;
//   } catch (e) {
//     print(e);
//     return false;
//   }
// }
}
