class UserModel {
  final String id;
  final String name;
  final String email;
  final String imgUrl;
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.imgUrl,
    required this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imgUrl': imgUrl,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      id: documentId,
      name: map['name'] as String,
      email: map['email'] as String,
      imgUrl: map['imgUrl'] as String,
      isAdmin: map['isAdmin'] as bool,
    );
  }
}
