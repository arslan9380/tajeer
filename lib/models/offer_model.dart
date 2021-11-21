import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tajeer/models/item_model.dart';
import 'package:tajeer/models/user_model.dart';

class OfferModel {
  String id;
  String sendToId;
  String sendById;
  String status;
  ItemModel item;
  String rentPerDay;
  Timestamp startDate;
  Timestamp endDate;
  UserModel ownerModel;
  UserModel renterModel;
  String note;

  OfferModel(
      {this.id,
      this.sendToId,
      this.sendById,
      this.status,
      this.item,
      this.rentPerDay,
      this.startDate,
      this.endDate,
      this.ownerModel,
      this.renterModel,
      this.note});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'sendToId': this.sendToId,
      'sendById': this.sendById,
      'status': this.status,
      'item': this.item.toMap(),
      'rentPerDay': this.rentPerDay,
      'startDate': this.startDate,
      'endDate': this.endDate,
      'ownerModel': this.ownerModel.toMap(),
      'renterModel': this.renterModel.toMap(),
      'note': this.note
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
        id: map['id'] as String,
        sendToId: map['sendToId'] as String,
        sendById: map['sendById'] as String,
        status: map['status'],
        item: ItemModel.fromMap(map['item']),
        rentPerDay: map['rentPerDay'] as String,
        startDate: map['startDate'] as Timestamp,
        endDate: map['endDate'] as Timestamp,
        note: map['note'],
        ownerModel: UserModel.fromMap(map['ownerModel']),
        renterModel: UserModel.fromMap(map['renterModel']));
  }
}
