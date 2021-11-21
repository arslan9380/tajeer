import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/app/static_info.dart';
import 'package:tajeer/models/item_model.dart';
import 'package:tajeer/models/user_model.dart';
import 'package:tajeer/services/auth_service.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/services/item_service.dart';
import 'package:tajeer/view/ui/add_item/add_item.dart';

class ProfileViewModel extends BaseViewModel with CommonUiService {
  List<ItemModel> myAllItems = [];
  List<ItemModel> publishedItem = [];
  List<ItemModel> hideItems = [];
  bool loading = true;
  ItemService itemService = locator<ItemService>();
  AuthService authService = locator<AuthService>();
  String msg = "";
  UserModel userModel;
  bool proccesing = false;

  setProcessing(bool val) {
    proccesing = val;
    notifyListeners();
  }

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

  deleteItem(ItemModel itemModel) async {
    setProcessing(true);
    await itemService.deleteItem(itemModel);
    myAllItems.removeWhere((element) => element.id == itemModel.id);
    publishedItem =
        myAllItems.where((element) => element.isPublished == true).toList();
    hideItems =
        myAllItems.where((element) => element.isPublished == false).toList();
    setProcessing(false);
    showSnackBar("Deleted Successfully");
  }

  editItem(ItemModel itemModel) async {
    var response = await Get.to(() => AddItemView(
          itemModel: itemModel,
        ));

    if (response != null) {
      print(response);
      ItemModel item = response;
      int index = myAllItems.indexWhere((element) => element.id == item.id);
      myAllItems[index] = item;
      publishedItem =
          myAllItems.where((element) => element.isPublished == true).toList();
      hideItems =
          myAllItems.where((element) => element.isPublished == false).toList();
      notifyListeners();
    }
  }

  hideItem(ItemModel itemModel) async {
    setProcessing(true);
    itemModel.isPublished = false;
    await itemService.addItem(itemModel);

    int index = myAllItems.indexWhere((element) => element.id == itemModel.id);
    myAllItems[index] = itemModel;
    publishedItem =
        myAllItems.where((element) => element.isPublished == true).toList();
    hideItems =
        myAllItems.where((element) => element.isPublished == false).toList();
    setProcessing(false);
  }

  Future<void> publishItem(ItemModel itemModel) async {
    setProcessing(true);
    itemModel.isPublished = true;
    await itemService.addItem(itemModel);
    int index = myAllItems.indexWhere((element) => element.id == itemModel.id);
    myAllItems[index] = itemModel;
    publishedItem =
        myAllItems.where((element) => element.isPublished == true).toList();
    hideItems =
        myAllItems.where((element) => element.isPublished == false).toList();
    setProcessing(false);
  }
}
