import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/view/widgets/description_field.dart';
import 'package:tajeer/view/widgets/inputfield_widget.dart';

import 'add_event_viewmodel.dart';

class AddEventView extends StatefulWidget {
  @override
  _AddEventViewState createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  TextEditingController titleCon = TextEditingController();
  TextEditingController locationCon = TextEditingController();
  TextEditingController priceCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  TextEditingController timeCon = TextEditingController();
  TextEditingController descriptionCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddEventViewModel>.reactive(
        viewModelBuilder: () => AddEventViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "ADD EVENT",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: ModalProgressHUD(
                inAsyncCall: model.loading,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          model.pickImage();
                        },
                        child: Container(
                          height: Get.width * 0.7,
                          width: Get.width,
                          child: model.eventImage != ""
                              ? Image.file(
                                  File(model.eventImage),
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Image.asset(
                                    "assets/image_placeholder.png",
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 3,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: hMargin, vertical: vMargin),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            InputFieldWidget(
                              hint: "Title",
                              controller: titleCon,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InputFieldWidget(
                              hint: "Event Location",
                              enable: true,
                              controller: locationCon,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: Get.height * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.5),
                                border: Border.all(
                                    width: 1.0,
                                    color: Theme.of(context).primaryColorLight),
                              ),
                              child: RawScrollbar(
                                thumbColor: Theme.of(context).primaryColor,
                                isAlwaysShown: true,
                                child: DescriptionField(
                                  hint: "Description",
                                  controller: descriptionCon,
                                  maxLines: 1000,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                                width: Get.width,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Event Type?",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: RadioListTile(
                                      value: "Free",
                                      title: Text(
                                        "Free",
                                      ),
                                      groupValue: model.eventType,
                                      onChanged: model.setEventType),
                                ),
                                Flexible(
                                  child: RadioListTile(
                                      value: "Paid",
                                      title: Text(
                                        "Paid",
                                      ),
                                      groupValue: model.eventType,
                                      onChanged: model.setEventType),
                                ),
                              ],
                            ),
                            if (model.eventType == "Paid")
                              InputFieldWidget(
                                hint: "Price",
                                controller: priceCon,
                              ),
                            SizedBox(
                              height: 16,
                            ),
                            InkWell(
                              onTap: () {
                                model.createEvent(
                                    titleCon.text,
                                    locationCon.text,
                                    descriptionCon.text,
                                    priceCon.text,
                                    timeCon.text);
                              },
                              child: Container(
                                width: Get.width * 0.7,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(27.5)),
                                child: Center(
                                  child: Text(
                                    "Create Event",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
