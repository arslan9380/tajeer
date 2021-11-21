import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/app/static_info.dart';
import 'package:tajeer/models/item_model.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/services/item_service.dart';

class AddItemViewModel extends BaseViewModel {
  String itemImage = "";
  TextEditingController catCon = TextEditingController();
  CommonUiService commonUiService = locator<CommonUiService>();
  ItemService itemService = locator<ItemService>();
  bool loading = false;
  List<String> itemCats = [
    "Household",
    "Electronics",
    "Property",
    "Vehicle",
    "Others"
  ];

  String selectedCat = "";
  bool isExpanded = false;

  setExpanded() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  setEventType(String eventTyp) {
    selectedCat = eventTyp;
    isExpanded = !isExpanded;
    catCon.text = selectedCat;
    notifyListeners();
  }

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  Future<void> pickImage() async {
    var picked;
    picked = await ImagePicker().getImage(source: ImageSource.gallery);
    if (picked != null) {
      var cropped = await ImageCropper.cropImage(
        sourcePath: picked.path,
        compressQuality: 100,
        cropStyle: CropStyle.rectangle,
        aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 2),
      );
      if (cropped != null) {
        itemImage = cropped.path;
        notifyListeners();
      }
    }
  }

  Future<void> addItem(String title, String location, String rentPerDay,
      String description, ItemModel originalItem) async {
    if (originalItem != null) {
      selectedCat = originalItem.category;
    }
    if (title.isEmpty ||
        location.isEmpty ||
        description.isEmpty ||
        rentPerDay.isEmpty ||
        selectedCat.isEmpty) {
      commonUiService.showSnackBar("Please fill all the fields");
      return;
    }
    if (originalItem == null) {
      if (itemImage.isEmpty) {
        commonUiService.showSnackBar("Please add Image");
      }
    }

    ItemModel itemModel = ItemModel(
        id: originalItem?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        image: itemImage ?? originalItem.image,
        title: title,
        category: selectedCat,
        rentPerDay: rentPerDay,
        location: location,
        description: description,
        addedById: StaticInfo.userModel.id,
        addedByName:
            StaticInfo.userModel.fistName + " " + StaticInfo.userModel.lastName,
        addedByPhoto: StaticInfo.userModel.image,
        addedTime: Timestamp.now(),
        isPublished: true);

    setLoading(true);
    var result = await itemService.addItem(itemModel);
    setLoading(false);
    if (result != false) {
      ItemModel item = result;
      Get.back(result: item);
      if (itemModel != null) {
        commonUiService.showSnackBar("Event Updated Successfully");
      } else {
        commonUiService.showSnackBar("Event Added Successfully");
      }
    } else {
      commonUiService.showSnackBar("Please try again later");
    }
  }
}
