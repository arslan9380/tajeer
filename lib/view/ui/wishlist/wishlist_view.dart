import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/view/ui/item_detail/item_detail.dart';
import 'package:tajeer/view/ui/wishlist/wishlist_viewmodel.dart';
import 'package:tajeer/view/widgets/item_widget.dart';
import 'package:tajeer/view/widgets/no_event_widget.dart';

class WishlistView extends StatefulWidget {
  @override
  _WishlistViewState createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  TextEditingController searchCon = TextEditingController();
  ScrollController wishlistController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WishlistViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: model.loading
            ? Center(child: CircularProgressIndicator())
            : model.msg != ""
                ? Text(model.msg)
                : ModalProgressHUD(
                    inAsyncCall: model.isProcessing,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: hMargin, vertical: vMargin),
                      child: Column(
                        children: [
                          model.wishlistItems.length == 0
                              ? Center(child: NoEventWidget(false))
                              : Expanded(
                                  child: RawScrollbar(
                                    thumbColor: Theme.of(context).primaryColor,
                                    isAlwaysShown: true,
                                    controller: wishlistController,
                                    child: SingleChildScrollView(
                                      controller: wishlistController,
                                      physics: BouncingScrollPhysics(),
                                      child: ListView.builder(
                                          itemCount: model.wishlistItems.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (_, index) {
                                            return InkWell(
                                                onTap: () {
                                                  Get.to(() => ItemDetail(
                                                        itemModel: model
                                                            .wishlistItems[
                                                                index]
                                                            .itemModel,
                                                      ));
                                                },
                                                child: ItemWidget(
                                                  isFavourite: true,
                                                  itemModel: model
                                                      .wishlistItems[index]
                                                      .itemModel,
                                                  onFavouriteTap: () {
                                                    model.removeFavourite(model
                                                        .wishlistItems[index]);
                                                  },
                                                ));
                                          }),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
      ),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      viewModelBuilder: () => locator<WishlistViewModel>(),
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.getWishlist()),
    );
  }
}
