import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String uid, name;
  Timestamp dateTime;
  bool newMsg;
  String lastMsg;
  String imageUrl;
  Chat(this.uid, this.name, this.dateTime, this.newMsg, this.lastMsg,
      this.imageUrl);
}
