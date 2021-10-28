import 'package:stacked/stacked.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/services/auth_service.dart';

class UserHomeViewModel extends IndexTrackingViewModel {
  AuthService authService = locator<AuthService>();

  void logout() {
    authService.logout();
  }
}
