import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/models/event_model.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/services/event_service.dart';

class AddItemViewModel extends BaseViewModel {
  String eventImage = "";
  String eventType = "Free";
  DateTime selectedTime = DateTime.now();
  TextEditingController catCon = TextEditingController();

  List<DateTime> pickedDate = [];
  CommonUiService commonUiService = locator<CommonUiService>();
  EventService eventService = locator<EventService>();
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
    await Get.dialog(AlertDialog(
      title: Text('Pick one source for image'),
      actions: [
        FlatButton(
            onPressed: () async {
              Get.back();
              picked =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              if (picked != null) {
                var cropped = await ImageCropper.cropImage(
                  sourcePath: picked.path,
                  compressQuality: 100,
                  cropStyle: CropStyle.rectangle,
                  aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 2),
                );
                if (cropped != null) {
                  eventImage = cropped.path;
                  notifyListeners();
                }
              }
            },
            child: Text('Gallery')),
        FlatButton(
            onPressed: () async {
              Get.back();
              picked = await ImagePicker().getImage(source: ImageSource.camera);
              if (picked != null) {
                var cropped = await ImageCropper.cropImage(
                  sourcePath: picked.path,
                  compressQuality: 100,
                  cropStyle: CropStyle.rectangle,
                  aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 2),
                );
                if (cropped != null) {
                  eventImage = cropped.path;
                  notifyListeners();
                }
              }
            },
            child: Text('Camera'))
      ],
    ));
  }

  Future<void> createEvent(String title, String location, String description,
      String price, String timeCon) async {
    print(title + location + price + timeCon);
    if (title.isEmpty ||
        location.isEmpty ||
        description.isEmpty ||
        timeCon.isEmpty ||
        pickedDate.length == 0 ||
        eventImage.isEmpty ||
        (eventType == "Paid" && price.isEmpty)) {
      commonUiService.showSnackBar("Please fill all the fields");
      return;
    }

    EventModel eventModel = EventModel(
      image: eventImage,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      startDate: Timestamp.fromDate(pickedDate[0]),
      isPaid: eventType == "Paid" ? true : false,
      location: location,
      price: price,
      startTime: Timestamp.fromDate(selectedTime),
    );

    if (pickedDate.length == 2) {
      eventModel.endDate = Timestamp.fromDate(pickedDate[1]);
    }

    setLoading(true);
    var result = await eventService.addEvent(eventModel);
    setLoading(false);
    if (result != false) {
      Get.back(result: result);
      commonUiService.showSnackBar("Event Added Successfully");
    } else {
      commonUiService.showSnackBar("Please try again later");
    }
  }
}