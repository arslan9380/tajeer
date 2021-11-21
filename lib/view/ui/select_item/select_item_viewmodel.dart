import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/app/static_info.dart';
import 'package:tajeer/models/item_model.dart';
import 'package:tajeer/services/item_service.dart';

class SelectItemViewModel extends BaseViewModel {
  List<ItemModel> myAllItems = [];
  List<ItemModel> publishedItem = [];
  bool loading = true;
  ItemService itemService = locator<ItemService>();
  String msg = "";

  setLaoding(bool val) {
    loading = val;
    notifyListeners();
  }

  getMyData() async {
    var response = await itemService.getItemsById(StaticInfo.userModel.id);
    if (response != false) {
      myAllItems = response;
      publishedItem =
          myAllItems.where((element) => element.isPublished == true).toList();
    } else {
      msg = "We're facing some problem\nPlease try again later";
    }
    setLaoding(false);
  }
}
