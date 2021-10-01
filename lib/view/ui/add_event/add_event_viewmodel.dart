import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class AddEventViewModel extends BaseViewModel {
  String eventImage;
  String eventType = "Free";

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

  void setEventType(value) {
    eventType = value;
    notifyListeners();
  }
}
