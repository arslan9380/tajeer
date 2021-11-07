import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:tajeer/app/locator.dart';
import 'package:tajeer/models/item_model.dart';

import 'image_service.dart';

@lazySingleton
class ItemService {
  String _itemKey = "items";
  ImageService imageService = locator<ImageService>();

  Future addItem(ItemModel itemModel) async {
    try {
      String url = await imageService.saveFiles(itemModel.image, "Images");
      if (url == null) return;
      itemModel.image = url;
      await FirebaseFirestore.instance
          .collection(_itemKey)
          .doc(itemModel.id)
          .set(itemModel.toMap(), SetOptions(merge: true));
      return ItemModel;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future getAllItems() async {
    List<ItemModel> allEvents = [];
    try {
      var result = await FirebaseFirestore.instance
          .collection(_itemKey)
          .where("isPublished", isEqualTo: true)
          .get();
      for (var doc in result.docs) {
        allEvents.add(ItemModel.fromMap(doc.data()));
      }
      print(allEvents.length);
      return allEvents;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future getItemsById(String id) async {
    List<ItemModel> allEvents = [];
    try {
      var result = await FirebaseFirestore.instance
          .collection(_itemKey)
          .where("addedById", isEqualTo: id)
          .get();
      for (var doc in result.docs) {
        allEvents.add(ItemModel.fromMap(doc.data()));
      }
      print(allEvents.length);
      return allEvents;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future deleteItem(ItemModel itemModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(_itemKey)
          .doc(itemModel.id)
          .delete();
      return ItemModel;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
