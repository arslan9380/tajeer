import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/models/chat.dart';
import 'package:tajeer/models/item_model.dart';
import 'package:tajeer/view/ui/select_item/select_item_view.dart';
import 'package:tajeer/view/ui/send_offer/send_offer_viewmodel.dart';
import 'package:tajeer/view/widgets/inputfield_widget.dart';
import 'package:tajeer/view/widgets/item_widget.dart';

class SendOffer extends StatefulWidget {
  final Chat chatModel;

  SendOffer({this.chatModel});

  @override
  _SendOfferState createState() => _SendOfferState();
}

class _SendOfferState extends State<SendOffer> {
  ItemModel itemModel;
  TextEditingController toDateCon = TextEditingController();
  TextEditingController fromDateCon = TextEditingController();
  TextEditingController rentCon = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  void initState() {
    print(widget.chatModel.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendOfferViewModel>.reactive(
        viewModelBuilder: () => SendOfferViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "Send Offer",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: ModalProgressHUD(
                inAsyncCall: model.procesing,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: hMargin, vertical: vMargin),
                    child: Column(
                      children: [
                        itemModel != null
                            ? Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  ItemWidget(
                                    itemModel: itemModel,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 12, right: 16),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 16,
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : InkWell(
                                onTap: () async {
                                  var selectedItem =
                                      await Get.to(() => SelectItemView());
                                  if (selectedItem != null) {
                                    setState(() {
                                      itemModel = selectedItem;
                                    });
                                  }
                                },
                                child: InputFieldWidget(
                                  hint: "Select Item",
                                  enable: false,
                                  showDropArrow: true,
                                ),
                              ),
                        SizedBox(
                          height: 16,
                        ),
                        InputFieldWidget(
                          hint: "Rent Per Day",
                          controller: rentCon,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Period Date:",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: SizedBox(
                                height: 50,
                                child: InkWell(
                                  onTap: () async {
                                    model.fromDate = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            model.fromDate ?? DateTime.now(),
                                        lastDate: DateTime(3000));
                                    if (model.fromDate != null) {
                                      fromDateCon.text = DateFormat("d-MMM-y")
                                          .format(model.fromDate);
                                    }
                                  },
                                  child: InputFieldWidget(
                                    label: "From",
                                    enable: false,
                                    controller: fromDateCon,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Flexible(
                              child: SizedBox(
                                height: 50,
                                child: InkWell(
                                  onTap: () async {
                                    model.toDate = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            model.toDate ?? DateTime.now(),
                                        lastDate: DateTime(3000));
                                    if (model.toDate != null) {
                                      toDateCon.text = DateFormat("d-MMM-y")
                                          .format(model.toDate);
                                    }
                                  },
                                  child: InputFieldWidget(
                                    label: "To",
                                    enable: false,
                                    controller: toDateCon,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Any Instruction:",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InputFieldWidget(
                          maxLines: 5,
                          controller: note,
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        InkWell(
                          onTap: () {
                            model.sendOffer(itemModel, widget.chatModel,
                                rentCon.text, note.text);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            width: Get.width * 0.6,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorDark,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text(
                                "Send Offer",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
