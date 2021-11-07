import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/app/static_info.dart';
import 'package:tajeer/view/ui/edit_profile/edit_profile_viewmodel.dart';
import 'package:tajeer/view/widgets/icon_button.dart';
import 'package:tajeer/view/widgets/inputfield_widget.dart';
import 'package:tajeer/view/widgets/round_image.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void initState() {
    firstName.text = StaticInfo.userModel.fistName;
    lastName.text = StaticInfo.userModel.lastName;
    phone.text = StaticInfo.userModel.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
        viewModelBuilder: () => EditProfileViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                leading: InkWell(
                    onTap: () => Get.back(),
                    child: IconButtonWidget(icon: Icons.arrow_back_ios_sharp)),
                title: Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                centerTitle: true,
                actions: [
                  InkWell(
                    onTap: model.setIsEdit,
                    child: Container(
                      height: 28,
                      width: 32,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: model.isEdit
                          ? InkWell(
                              onTap: () {
                                model.updateProfile(
                                    firstName.text, lastName.text, phone.text);
                              },
                              child: Center(child: Text("Save")))
                          : Image.asset(
                              "assets/edit_icon.png",
                              color: Colors.white,
                            ),
                    ),
                  )
                ],
              ),
              body: ModalProgressHUD(
                inAsyncCall: model.isProcessing,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: hMargin, vertical: vMargin),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        InkWell(
                          onTap: () {
                            if (model.isEdit) model.pickImage();
                          },
                          child: model.profileImage != null
                              ? Container(
                                  height: Get.width * 0.3,
                                  width: Get.width * 0.3,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                              File(model.profileImage)))),
                                )
                              : (StaticInfo.userModel.image == "" ||
                                      StaticInfo.userModel.image == null)
                                  ? Container(
                                      height: Get.width * 0.3,
                                      width: Get.width * 0.3,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x4cd3d1d8),
                                              blurRadius: 6,
                                              spreadRadius: 1,
                                              offset: Offset(0, 0),
                                            ),
                                          ],
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          image: DecorationImage(
                                              fit: BoxFit.fitHeight,
                                              image: AssetImage(
                                                  "assets/person_placeholder.png"))),
                                    )
                                  : RoundImage(
                                      radius: Get.width * 0.3,
                                      imageUrl: StaticInfo.userModel.image,
                                    ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputFieldWidget(
                          controller: firstName,
                          label: "First Name",
                          enable: model.isEdit,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputFieldWidget(
                          controller: lastName,
                          label: "Last Name",
                          enable: model.isEdit,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputFieldWidget(
                          controller: phone,
                          label: "Phone",
                          enable: model.isEdit,
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
