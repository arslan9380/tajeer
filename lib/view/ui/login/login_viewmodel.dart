import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
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

  void registerUser() {
    // Get.to(SignUpView());
  }
}
