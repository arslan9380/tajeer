import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tajeer/models/rating_model.dart';

class RatingService {
  String _ratingKey = "ratings";
  final _usersKey = 'users';

  addRating(double rating, String id) async {
    await FirebaseFirestore.instance.collection(_ratingKey).doc(id).set({
      "noOfRates": FieldValue.increment(1),
      "sum": FieldValue.increment(rating),
    }, SetOptions(merge: true));
    await updateUserRating(rating, id);
  }

  updateUserRating(double rating, String id) async {
    RatingModel ratingModel = RatingModel.fromMap(
        (await FirebaseFirestore.instance.collection(_ratingKey).doc(id).get())
            .data());
    double userRating = ratingModel.sum / ratingModel.noOfRates;
    print(userRating);
    try {
      await FirebaseFirestore.instance
          .collection(_usersKey)
          .doc(id)
          .set({"rating": userRating.toString()}, SetOptions(merge: true));
    } on Exception catch (e) {
      print(e);
      // TODO
    }
  }
}
