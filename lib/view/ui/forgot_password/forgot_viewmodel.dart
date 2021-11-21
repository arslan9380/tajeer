import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/services/auth_service.dart';
import 'package:tajeer/services/common_ui_service.dart';

class ForgotViewModel extends BaseViewModel {
  AuthService authService = locator<AuthService>();
  CommonUiService commonUiService = locator<CommonUiService>();
  bool loading = false;

  bool isRemember = true;

  setIsRemember(bool val) {
    isRemember = val;
    notifyListeners();
  }

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  Future<void> forgotPassword(String email) async {
    if (email.isEmpty) {
      commonUiService.showSnackBar("Please enter email");
      return;
    } else if (!GetUtils.isEmail(email)) {
      commonUiService.showSnackBar("Invalid email");
      return;
    }
    setLoading(true);
    await authService.resetPassword(email);
    setLoading(false);
    Get.back();
    commonUiService.showSnackBar(
        "We have sent you an email for reseting password\nPlease check your email");
  }
}
