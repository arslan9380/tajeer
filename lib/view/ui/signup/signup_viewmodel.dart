import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  bool loading = false;

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }
}
