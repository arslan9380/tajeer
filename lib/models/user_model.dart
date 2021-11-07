class UserModel {
  String id;
  String fistName;
  String lastName;
  String phone;
  String email;
  String image;
  String rating;
  String publishedItems;
  String hideItems;

  UserModel(
      {this.id,
      this.fistName,
      this.lastName,
      this.phone,
      this.email,
      this.image,
      this.rating,
      this.publishedItems,
      this.hideItems});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'fistName': this.fistName,
      'lastName': this.lastName,
      'phone': this.phone,
      'email': this.email,
      'image': this.image,
      'rating': this.rating,
      'publishedItems': this.publishedItems,
      'hideItems': this.hideItems,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      fistName: map['fistName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
      rating: map['rating'] as String,
      publishedItems: map['publishedItems'] as String,
      hideItems: map['hideItems'] as String,
    );
  }
}
