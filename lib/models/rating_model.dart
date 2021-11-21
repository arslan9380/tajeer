class RatingModel {
  int noOfRates;
  double sum;

  RatingModel({this.noOfRates, this.sum});

  Map<String, dynamic> toMap() {
    return {
      'noOfRates': this.noOfRates,
      'sum': this.sum,
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      noOfRates: map['noOfRates'] as int,
      sum: map['sum'] as double,
    );
  }
}
