import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/models/wishlist_model.dart';
import 'package:tajeer/services/wishlist_service.dart';

@singleton
class WishlistViewModel extends BaseViewModel {
  bool loading = true;
  bool isProcessing = false;
  List<WishlistModel> wishlistItems = [];
  WishlistService wishlistService = locator<WishlistService>();
  String msg = "";

  setProcessing(bool val) {
    isProcessing = val;
    notifyListeners();
  }

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  getWishlist() async {
    var response = await wishlistService.getAllItems();
    if (response == false) {
      msg = "We're facing some problem.\nPlease try again later";
    } else {
      wishlistItems = response;
    }
    setLoading(false);
  }

  removeFavourite(WishlistModel wishlistItem) async {
    setProcessing(true);
    print(wishlistItems.length);
    wishlistItems.removeWhere((element) => element.id == wishlistItem.id);
    print(wishlistItems.length);
    await wishlistService.deleteItem(wishlistItem);
    setProcessing(false);
  }
}
