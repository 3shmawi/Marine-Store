class CartModel {
  String? image;
  int number = 1;

  CartModel({
    required this.image,
    required this.number,
  });

  CartModel.fromJson(Map<String, dynamic>? json) {
    number = json!['number'] ?? 1;
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['image'] = image;
    return data;
  }
}
