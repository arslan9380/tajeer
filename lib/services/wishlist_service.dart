import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/app/static_info.dart';
import 'package:tajeer/models/wishlist_model.dart';

import 'image_service.dart';

@lazySingleton
class WishlistService {
  String _wishlistKey = "wishlist";
  ImageService imageService = locator<ImageService>();

  Future addItem(WishlistModel wishlistModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(_wishlistKey)
          .doc(wishlistModel.id)
          .set(wishlistModel.toMap(), SetOptions(merge: true));
      return wishlistModel;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future getAllItems() async {
    List<WishlistModel> wishlist = [];
    try {
      print("called");
      var result = await FirebaseFirestore.instance
          .collection(_wishlistKey)
          .where("addedBy", isEqualTo: StaticInfo.userModel.id)
          .get();

      for (var doc in result.docs) {
        print("fetched");
        wishlist.add(WishlistModel.fromMap(doc.data()));
      }
      return wishlist;
    } catch (e) {
      print("=====================Error");
      print("Error: $e");
      return false;
    }
  }

  Future deleteItem(WishlistModel wishlistModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(_wishlistKey)
          .doc(wishlistModel.id)
          .delete();
      return wishlistModel;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
