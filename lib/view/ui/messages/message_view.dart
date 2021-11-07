import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/view/ui/chat/chat_view.dart';
import 'package:tajeer/view/widgets/message_widget.dart';

import 'message_viewmodel.dart';

class MessageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageViewModel>.reactive(
        viewModelBuilder: () => MessageViewModel(),
        builder: (context, model, child) => Scaffold(
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 16, horizontal: hMargin),
                  child: Column(
                    children: [
                      ListView.builder(
                          itemCount: 16,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return InkWell(
                                onTap: () {
                                  Get.to(() => ChatView());
                                },
                                child: MessageWidget());
                          }),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                heroTag: "chat",
                elevation: 0.0,
                child: Icon(
                  Icons.chat,
                  size: 23,
                ),
              ),
            ));
  }
}
