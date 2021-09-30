import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  initialise() async {
    await Future.delayed(Duration(seconds: 4));
    // Get.off(OnBoardView());
  }
}
