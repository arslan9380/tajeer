import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/app/static_info.dart';
import 'package:tajeer/models/item_model.dart';
import 'package:tajeer/models/user_model.dart';
import 'package:tajeer/services/auth_service.dart';
import 'package:tajeer/services/item_service.dart';

class ProfileViewModel extends BaseViewModel {
  List<ItemModel> myAllItems = [];
  List<ItemModel> publishedItem = [];
  List<ItemModel> hideItems = [];
  bool loading = true;
  ItemService itemService = locator<ItemService>();
  AuthService authService = locator<AuthService>();
  String msg = "";
  UserModel userModel;

  setLaoding(bool val) {
    loading = val;
    notifyListeners();
  }

  getMyData(String id) async {
    if (id != null) {
      userModel = await authService.getUser(id);
    } else {
      userModel = StaticInfo.userModel;
    }
    var response = await itemService.getItemsById(userModel.id);
    if (response != false) {
      myAllItems = response;
      publishedItem =
          myAllItems.where((element) => element.isPublished == true).toList();
      hideItems =
          myAllItems.where((element) => element.isPublished == false).toList();
    } else {
      msg = "We're facing some problem\nPlease try again later";
    }
    setLaoding(false);
  }
}
