import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/app/static_info.dart';
import 'package:tajeer/models/user_model.dart';
import 'package:tajeer/services/auth_service.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/services/image_service.dart';

class EditProfileViewModel extends BaseViewModel {
  bool isEdit = false;
  String profileImage;
  bool isProcessing = false;
  CommonUiService commonUiService = locator<CommonUiService>();
  ImageService imageService = locator<ImageService>();
  AuthService authService = locator<AuthService>();

  setProcesing(bool val) {
    isProcessing = val;
    notifyListeners();
  }

  setIsEdit() {
    isEdit = !isEdit;
    notifyListeners();
  }

  Future<void> pickImage() async {
    var picked;
    picked = await ImagePicker().getImage(source: ImageSource.gallery);
    if (picked != null) {
      var cropped = await ImageCropper.cropImage(
        sourcePath: picked.path,
        compressQuality: 100,
        cropStyle: CropStyle.circle,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      );
      if (cropped != null) {
        profileImage = cropped.path;
        notifyListeners();
      }
    }
  }

  Future<void> updateProfile(
      String firstName, String lastName, String phone) async {
    if (firstName.isEmpty || lastName.isEmpty || phone.isEmpty) {
      commonUiService.showSnackBar("Please fill all the fields");
      return;
    }
    setProcesing(true);
    String imgUrl;
    if (profileImage != "") {
      imgUrl = await imageService.saveFiles(profileImage, "images");
    }
    UserModel userModel = UserModel(
        id: StaticInfo.userModel.id,
        image: imgUrl ?? StaticInfo.userModel.image,
        email: StaticInfo.userModel.email,
        phone: phone,
        fistName: firstName,
        hideItems: StaticInfo.userModel.hideItems,
        lastName: lastName,
        publishedItems: StaticInfo.userModel.publishedItems,
        rating: StaticInfo.userModel.hideItems);
    await authService.saveUser(userModel);
    StaticInfo.userModel = userModel;
    setProcesing(false);
    commonUiService.showSnackBar("Profile updated successfully");
  }
}
