class RateModel {
  final String id;
  final double rateValue;

  RateModel({
    required this.id,
    required this.rateValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rateValue': rateValue,
    };
  }

  factory RateModel.fromMap(Map<String, dynamic> map, String documentId) {
    return RateModel(
      id: documentId,
      rateValue: map['rateValue'] as double,
    );
  }
}
