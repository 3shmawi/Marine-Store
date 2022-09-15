class UserModel {
  String? uId;
  String? name;
  String? email;
  String? phone;
  String? image;

  UserModel({
    this.uId,
    this.name,
    this.email,
    this.phone,
    this.image,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    uId = json!['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = uId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    return data;
  }
}
