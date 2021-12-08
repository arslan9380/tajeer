import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/models/item_model.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/services/item_service.dart';

@singleton
class HomeViewModel extends IndexTrackingViewModel with CommonUiService {
  ItemService itemService = locator<ItemService>();
  String selectedCat = "All";
  List<String> itemCats = [
    "All",
    "Outdoor Living",
    "Light equipment",
    "Speakers and Party supplies",
    "Others"
  ];

  setCat(String cat) {
    selectedCat = cat;
    updateLists();
    notifyListeners();
  }

  bool loading = true;
  List<ItemModel> allItems = [];
  List<ItemModel> filteredItems = [];

  bool isProcessing = false;

  setProcessing(bool val) {
    isProcessing = val;
    notifyListeners();
  }

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  initialise() async {
    setLoading(true);
    var response = await itemService.getAllItems();
    if (response != false) {
      allItems = response;
      filteredItems = allItems;
    }
    setLoading(false);
  }

  // deleteEvent(ItemModel itemModel) async {
  //   setProcessing(true);
  //   var response = await itemService.deleteItem(itemModel);
  //   setProcessing(false);
  //   if (response != false) {
  //     allItems.remove(ItemModel);
  //     updateLists();
  //     showSnackBar("Event Deleted");
  //   } else {
  //     showSnackBar("Please try again later");
  //   }
  // }

  void updateLists() {
    if (selectedCat == "All") {
      filteredItems = allItems;
    } else {
      filteredItems = allItems
          .where((element) =>
              element.category.toLowerCase() == selectedCat.toLowerCase())
          .toList();
    }
    notifyListeners();
  }

  onFilter(String key) {
    if (key != "") {
      if (selectedCat == "All") {
        filteredItems = allItems;
        print("1 " + filteredItems.length.toString());
      } else {
        filteredItems = allItems
            .where((element) =>
                element.category.toLowerCase() == selectedCat.toLowerCase())
            .toList();
        print("2 " + filteredItems.length.toString());
      }

      filteredItems = filteredItems.where((element) {
        print(element.title.toLowerCase().contains(key));
        return element.title.toLowerCase().contains(key);
      }).toList();
      print("3 " + filteredItems.length.toString());
    } else {
      if (selectedCat == "All") {
        filteredItems = allItems;
        print("4 " + filteredItems.length.toString());
      } else {
        filteredItems = allItems
            .where((element) =>
                element.category.toLowerCase() == selectedCat.toLowerCase())
            .toList();
        print("5 " + filteredItems.length.toString());
      }
    }
    notifyListeners();
  }
}
