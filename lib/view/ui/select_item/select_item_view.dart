import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/view/ui/select_item/select_item_viewmodel.dart';
import 'package:tajeer/view/widgets/item_widget.dart';
import 'package:tajeer/view/widgets/no_event_widget.dart';

class SelectItemView extends StatefulWidget {
  @override
  _SelectItemViewState createState() => _SelectItemViewState();
}

class _SelectItemViewState extends State<SelectItemView> {
  ScrollController _publishedScrollCon = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectItemViewModel>.reactive(
        viewModelBuilder: () => SelectItemViewModel(),
        onModelReady: (model) => SchedulerBinding.instance
            .addPostFrameCallback((_) => model.getMyData()),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "Select Item",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: model.loading
                  ? Center(child: CircularProgressIndicator())
                  : model.msg != ""
                      ? Text(model.msg)
                      : SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: hMargin, vertical: vMargin),
                            child: Column(
                              children: [
                                RawScrollbar(
                                  thumbColor: Theme.of(context).primaryColor,
                                  isAlwaysShown: true,
                                  controller: _publishedScrollCon,
                                  child: SingleChildScrollView(
                                    controller: _publishedScrollCon,
                                    physics: BouncingScrollPhysics(),
                                    child: model.publishedItem.length == 0
                                        ? NoEventWidget(false)
                                        : ListView.builder(
                                            itemCount:
                                                model.publishedItem.length,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.all(5),
                                            itemBuilder: (_, index) {
                                              return InkWell(
                                                  onTap: () {
                                                    Get.back(
                                                        result:
                                                            model.publishedItem[
                                                                index]);
                                                  },
                                                  child: IgnorePointer(
                                                    ignoring: true,
                                                    child: ItemWidget(
                                                      itemModel: model
                                                          .publishedItem[index],
                                                    ),
                                                  ));
                                            }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
            ));
  }
}
