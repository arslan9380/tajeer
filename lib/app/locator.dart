import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tajeer/services/auth_service.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/services/event_service.dart';
import 'package:tajeer/services/image_service.dart';
import 'package:tajeer/view/ui/event/event_viewmodel.dart';

final locator = GetIt.instance;

@injectableInit
void setupLocator() {
  locator.registerLazySingleton(() => CommonUiService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => EventService());
  locator.registerLazySingleton(() => ImageService());
  locator.registerSingleton<EventViewModel>(EventViewModel());
}
