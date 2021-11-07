import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/models/user_model.dart';
import 'package:tajeer/services/auth_service.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/view/ui/user_home/user_home_view.dart';

class SignUpViewModel extends BaseViewModel {
  AuthService authService = locator<AuthService>();
  CommonUiService commonUiService = locator<CommonUiService>();
  bool loading = false;

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  signUpUser(String name, String lastName, String email, String phone,
      String password, String confirmPass) async {
    if (name.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty) {
      commonUiService.showSnackBar("Please fill all the details");
      return;
    } else if (password.length < 6) {
      commonUiService.showSnackBar("Password should be at least 6 character");
      return;
    }
    if (password != confirmPass) {
      commonUiService.showSnackBar("Password is not same.");
      return;
    }

    UserModel user = UserModel(
      fistName: name,
      lastName: lastName,
      phone: phone,
      email: email,
    );
    setLoading(true);
    var result = await authService.signUp(user, password);
    setLoading(false);
    if (result == "success") {
      Get.offAll(() => UserHomeView());
    } else {
      if (result == AuthStatus.ERROR_INVALID_EMAIL) {
        commonUiService.showSnackBar("Email address is invalid");
      } else if (result == AuthStatus.ERROR_WEAK_PASSWORD) {
        commonUiService
            .showSnackBar("Password should be at least 6 characters");
      } else if (result == AuthStatus.ERROR_EMAIL_ALREADY_IN_USE) {
        commonUiService.showSnackBar("Email already in use");
      } else {
        commonUiService.showSnackBar(result);
      }
    }
  }
}
