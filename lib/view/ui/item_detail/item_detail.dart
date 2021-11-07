import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/app/static_info.dart';
import 'package:tajeer/models/chat.dart';
import 'package:tajeer/models/item_model.dart';
import 'package:tajeer/view/ui/chat/chat_view.dart';
import 'package:tajeer/view/ui/item_detail/item_detail_viewmodel.dart';
import 'package:tajeer/view/ui/profile/profile_view.dart';
import 'package:tajeer/view/widgets/description_field.dart';
import 'package:tajeer/view/widgets/icon_button.dart';
import 'package:tajeer/view/widgets/inputfield_widget.dart';
import 'package:tajeer/view/widgets/rect_image.dart';

class ItemDetail extends StatelessWidget {
  final ItemModel itemModel;

  ItemDetail({this.itemModel});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemDetailViewModel>.reactive(
        viewModelBuilder: () => ItemDetailViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                leading: InkWell(
                    onTap: () => Get.back(),
                    child: IconButtonWidget(icon: Icons.arrow_back_ios_sharp)),
                title: Text(
                  "Item Detail",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                centerTitle: true,
                actions: [
                  if (StaticInfo.userModel.id != itemModel.addedById)
                    PopupMenuButton(
                      onSelected: (String value) async {
                        if (value == "wishlist") {
                          model.addToWisList(itemModel);
                          Get.snackbar("Sucess!", "Added to you Wishlist",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Theme.of(context).primaryColor,
                              colorText: Theme.of(context).primaryColorDark,
                              duration: Duration(seconds: 1));
                        } else if (value == "chat") {
                          Get.to(() => ChatView(
                                chat: Chat(
                                    itemModel.addedById,
                                    itemModel.addedByName,
                                    Timestamp.now(),
                                    false,
                                    "",
                                    itemModel.addedByPhoto),
                              ));
                        } else if (value == "profile") {
                          Get.to(() => ProfileView(
                                userId: itemModel.addedById,
                              ));
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'wishlist',
                          child: Text('Add to Wishlist'),
                        ),
                        PopupMenuItem<String>(
                          value: 'chat',
                          child: Text("Let's Chat"),
                        ),
                        const PopupMenuItem<String>(
                          value: 'profile',
                          child: Text('Profile'),
                        ),
                      ],
                      child: Container(
                        margin: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: Get.width * 0.7,
                      width: Get.width,
                      child: RectImage(
                        imageUrl: itemModel.image,
                      ),
                    ),
                    Divider(
                      height: 2,
                      thickness: 3,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: hMargin, vertical: vMargin),
                      child: Column(
                        children: [
                          InputFieldWidget(
                            controller:
                                TextEditingController(text: itemModel.title),
                            label: "Title",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputFieldWidget(
                            controller:
                                TextEditingController(text: itemModel.category),
                            label: "Category",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputFieldWidget(
                            controller: TextEditingController(
                                text: "${itemModel.rentPerDay}\$"),
                            label: "Rent Per Day",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputFieldWidget(
                            controller:
                                TextEditingController(text: itemModel.location),
                            label: "Location",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: Get.height * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.5),
                              border:
                                  Border.all(width: 1.0, color: Colors.grey),
                            ),
                            child: DescriptionField(
                              hint: "Description",
                              controller: TextEditingController(
                                  text: itemModel.description),
                              maxLines: 1000,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
