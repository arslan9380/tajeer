import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tajeer/services/auth_service.dart';
import 'package:tajeer/services/common_ui_service.dart';
import 'package:tajeer/services/image_service.dart';
import 'package:tajeer/services/item_service.dart';
import 'package:tajeer/services/wishlist_service.dart';
import 'package:tajeer/view/ui/home/home_viewmodel.dart';
import 'package:tajeer/view/ui/wishlist/wishlist_viewmodel.dart';

final locator = GetIt.instance;

@injectableInit
void setupLocator() {
  locator.registerLazySingleton(() => CommonUiService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => ItemService());
  locator.registerLazySingleton(() => ImageService());
  locator.registerLazySingleton(() => WishlistService());

  locator.registerSingleton<HomeViewModel>(HomeViewModel());
  locator.registerSingleton<WishlistViewModel>(WishlistViewModel());
}
