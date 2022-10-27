class AdminsModel {
  final String id;

  AdminsModel({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory AdminsModel.fromMap(Map<String, dynamic> map, String documentId) {
    return AdminsModel(
      id: documentId,
    );
  }
}
