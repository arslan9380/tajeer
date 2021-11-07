import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String id;
  String image;
  String title;
  String category;
  String rentPerDay;
  String location;
  String description;
  String addedById;
  Timestamp addedTime;
  String addedByName;
  bool isPublished;
  String addedByPhoto;

  ItemModel(
      {this.id,
      this.image,
      this.title,
      this.category,
      this.rentPerDay,
      this.location,
      this.description,
      this.addedById,
      this.addedTime,
      this.addedByName,
      this.isPublished,
      this.addedByPhoto});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'image': this.image,
      'title': this.title,
      'category': this.category,
      'rentPerDay': this.rentPerDay,
      'location': this.location,
      'description': this.description,
      'addedById': this.addedById,
      'addedTime': this.addedTime,
      'addedByName': this.addedByName,
      'isPublished': this.isPublished,
      'addedByPhoto': this.addedByPhoto,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as String,
      image: map['image'] as String,
      title: map['title'] as String,
      category: map['category'] as String,
      rentPerDay: map['rentPerDay'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      addedById: map['addedById'] as String,
      addedTime: map['addedTime'] as Timestamp,
      addedByName: map['addedByName'] as String,
      isPublished: map['isPublished'] as bool,
      addedByPhoto: map['addedByPhoto'] as String,
    );
  }
}
