import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/services/auth_service.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/view/ui/user_home/user_home_view.dart';

class LoginViewModel extends BaseViewModel {
  AuthService authService = locator<AuthService>();
  CommonUiService commonUiService = locator<CommonUiService>();
  bool loading = false;
  AuthService authServiceClass = AuthService();

  bool isRemember = true;

  setIsRemember(bool val) {
    isRemember = val;
    notifyListeners();
  }

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  Future<void> loginUser(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      commonUiService.showSnackBar("Please fill all the fields");
      return;
    } else if (!GetUtils.isEmail(email)) {
      commonUiService.showSnackBar("Invalid Email");
      return;
    }
    setLoading(true);
    var result = await authService.login(email, password);
    setLoading(false);
    if (result == "success") {
      Get.offAll(() => UserHomeView());
    } else {
      if (result == AuthStatus.ERROR_INVALID_EMAIL) {
        commonUiService.showSnackBar("Email address is invalid");
      } else if (result == AuthStatus.ERROR_WRONG_PASSWORD) {
        commonUiService.showSnackBar("Wrong password");
      } else if (result == AuthStatus.ERROR_USER_NOT_FOUND) {
        commonUiService.showSnackBar("User not found");
      } else {
        commonUiService.showSnackBar(result);
      }
    }
  }

  void forgotPassword() {}
}
