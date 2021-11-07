import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
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
      viewModelBuilder: () => WishlistViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: model.loading
            ? Center(child: CircularProgressIndicator())
            : ModalProgressHUD(
                inAsyncCall: model.isProcessing,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: hMargin, vertical: vMargin),
                  child: Column(
                    children: [
                      model.wishlistItems.length == -1
                          ? NoEventWidget(false)
                          : Expanded(
                              child: RawScrollbar(
                                thumbColor: Theme.of(context).primaryColor,
                                isAlwaysShown: true,
                                controller: wishlistController,
                                child: SingleChildScrollView(
                                  controller: wishlistController,
                                  physics: BouncingScrollPhysics(),
                                  child: ListView.builder(
                                      itemCount: 8,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(5),
                                      itemBuilder: (_, index) {
                                        return InkWell(
                                            onTap: () {},
                                            child: ItemWidget(
                                              isFavourite: true,
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
      onModelReady: (model) =>
          SchedulerBinding.instance.addPostFrameCallback((_) => () {}),
    );
  }
}
