import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/view/widgets/inputfield_widget.dart';
import 'package:tajeer/view/widgets/item_widget.dart';
import 'package:tajeer/view/widgets/no_event_widget.dart';

import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchCon = TextEditingController();
  ScrollController _itemController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => locator<HomeViewModel>(),
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
                      InputFieldWidget(
                        controller: searchCon,
                        prefixIcon: Icons.search,
                        hint: "Search Item",
                        onChange: model.onFilter,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 20,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.itemCats.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  model.setCat(model.itemCats[index]);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 16),
                                  alignment: Alignment.center,
                                  child: Text(
                                    model.itemCats[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: model.selectedCat ==
                                                model.itemCats[index]
                                            ? Theme.of(context).primaryColorDark
                                            : Theme.of(context).primaryColor,
                                        fontSize: model.selectedCat ==
                                                model.itemCats[index]
                                            ? 18
                                            : 14,
                                        fontFamily: model.selectedCat ==
                                                model.itemCats[index]
                                            ? GoogleFonts.aclonica().fontFamily
                                            : GoogleFonts.openSans().fontFamily,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      model.upcomingFiltered.length == -1
                          ? NoEventWidget(false)
                          : Expanded(
                              child: RawScrollbar(
                                thumbColor: Theme.of(context).primaryColor,
                                isAlwaysShown: true,
                                controller: _itemController,
                                child: SingleChildScrollView(
                                  controller: _itemController,
                                  physics: BouncingScrollPhysics(),
                                  child: ListView.builder(
                                      itemCount: 5,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(5),
                                      itemBuilder: (_, index) {
                                        return InkWell(
                                            onTap: () {}, child: ItemWidget());
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
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.initialise()),
    );
  }
}
