import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/view/widgets/icon_button.dart';
import 'package:tajeer/view/widgets/msg_receive_widget.dart';
import 'package:tajeer/view/widgets/msg_send_widget.dart';

import 'chat_viewmodel.dart';

class ChatView extends StatelessWidget {
  final FocusNode msgFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
        viewModelBuilder: () => ChatViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                leading: InkWell(
                    onTap: () => Get.back(),
                    child: IconButtonWidget(icon: Icons.arrow_back_ios_sharp)),
                title: Text(
                  "Minni Ramsey",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                centerTitle: true,
                // actions: [Icon(Icons.more_vert)],
              ),
              body: WillPopScope(
                onWillPop: () {
                  Get.back();
                  return;
                },
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: hMargin),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 12,
                                  itemBuilder: (_, index) {
                                    return index % 2 == 0
                                        ? MsgReceiveWidget()
                                        : MsgSendWidget();
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27.5),
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Flexible(
                                    child: TextField(
                                      maxLines: null,
                                      controller: model.msgCon,
                                      focusNode: msgFocus,
                                      onTap: () {},
                                      decoration: InputDecoration(
                                        hintText: "Write a message…",
                                        hintStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Icon(
                                    Icons.camera_alt,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ));
  }
}
