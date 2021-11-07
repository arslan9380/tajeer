import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/app/static_info.dart';
import 'package:tajeer/models/item_model.dart';
import 'package:tajeer/models/wishlist_model.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/services/wishlist_service.dart';
import 'package:tajeer/view/ui/wishlist/wishlist_viewmodel.dart';

class ItemDetailViewModel extends BaseViewModel {
  WishlistService wishlistService = locator<WishlistService>();
  CommonUiService commonUiService = locator<CommonUiService>();

  addToWisList(ItemModel itemModel) {
    WishlistModel wishlistModel = WishlistModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        addedBy: StaticInfo.userModel.id,
        itemId: itemModel.id,
        itemModel: itemModel);
    locator<WishlistViewModel>().wishlistItems.add(wishlistModel);
    wishlistService.addItem(wishlistModel);
  }
}
