import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  final TextEditingController msgCon = TextEditingController();
  bool showEmoji = false;

  onBackspacePressed() {
    msgCon
      ..text = msgCon.text.characters.skipLast(1).toString()
      ..selection =
          TextSelection.fromPosition(TextPosition(offset: msgCon.text.length));
  }
}
