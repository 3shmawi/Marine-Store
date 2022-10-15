class CarouselSliderModel {
  final String id;

  final String imgUrl;

  CarouselSliderModel({
    required this.id,
    required this.imgUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imgUrl': imgUrl,
    };
  }

  factory CarouselSliderModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return CarouselSliderModel(
      id: documentId,
      imgUrl: map['imgUrl'] as String,
    );
  }
}
