import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/models/chat.dart';
import 'package:tajeer/services/message_helper.dart';
import 'package:tajeer/view/ui/chat/chat_view.dart';
import 'package:tajeer/view/widgets/message_widget.dart';

import 'message_viewmodel.dart';

class MessageView extends StatefulWidget {
  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  bool notify = false;
  String s;
  var subscription;
  MessageHelper helper;
  List<Chat> chats;
  List<Chat> filteredList;

  @override
  void initState() {
    super.initState();
    helper = MessageHelper.withChatStreamInitialized();
    subscription = helper.chatStream.listen((data) {
      setState(() {
        chats = data;
        chats.sort((b, a) => a.dateTime.compareTo(b.dateTime));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageViewModel>.reactive(
        viewModelBuilder: () => MessageViewModel(),
        builder: (context, model, child) => Scaffold(
              body: chats == null
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 16, horizontal: hMargin),
                        child: Column(
                          children: [
                            ListView.builder(
                                itemCount: chats.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) {
                                  return InkWell(
                                      onTap: () {
                                        Get.to(() => ChatView(
                                              chat: chats[index],
                                            ));
                                      },
                                      child: MessageWidget(
                                        chat: chats[index],
                                        onDelete: () {
                                          Get.defaultDialog(
                                              title:
                                                  "Are you sure you want to delete this chat?",
                                              middleText: "",
                                              buttonColor: Theme.of(context)
                                                  .primaryColor,
                                              confirmTextColor: Colors.white,
                                              onCancel: () {
                                                Get.back();
                                              },
                                              textConfirm: "  Delete  ",
                                              onConfirm: () {
                                                Get.back();
                                                MessageHelper().deleteChat(
                                                    chats[index].uid);
                                              });
                                        },
                                      ));
                                }),
                          ],
                        ),
                      ),
                    ),
            ));
  }
}
