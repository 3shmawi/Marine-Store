

class ProductModel {
  final String id;
  final String title;
  final int price;
  final String imgUrl;
  final String description;
  final int? discountValue;
  final String category;
  final int? rate;


  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imgUrl,
    required this.description,
    required this.category,
    this.discountValue,
    this.rate,

  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imgUrl': imgUrl,
      'description': description,
      'discountValue': discountValue,
      'category': category,
      'rate': rate,

    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ProductModel(
      id: documentId,
      title: map['title'] as String,
      price: map['price'] as int,
      imgUrl: map['imgUrl'] as String,
      description: map['description'] as String,
      discountValue: map['discountValue'] as int,
      category: map['category'] as String,
      rate: map['rate'] as int,
    );
  }
}

// List<ProductModel> dummyProducts = [
//   ProductModel(
//     id: '1',
//     title: 'T-shirt',
//     price: 300,
//     imgUrl: AppAssets.tempProductAsset1,
//     category: 'Clothes',
//     discountValue: 20,
//   ),
//   ProductModel(
//     id: '1',
//     title: 'T-shirt',
//     price: 300,
//     imgUrl: AppAssets.tempProductAsset1,
//     category: 'Clothes',
//     discountValue: 20,
//   ),
//   ProductModel(
//     id: '1',
//     title: 'T-shirt',
//     price: 300,
//     imgUrl: AppAssets.tempProductAsset1,
//     category: 'Clothes',
//     discountValue: 20,
//   ),
//   ProductModel(
//     id: '1',
//     title: 'T-shirt',
//     price: 300,
//     imgUrl: AppAssets.tempProductAsset1,
//     category: 'Clothes',
//     discountValue: 20,
//   ),
//   ProductModel(
//     id: '1',
//     title: 'T-shirt',
//     price: 300,
//     imgUrl: AppAssets.tempProductAsset1,
//     category: 'Clothes',
//   ),
//   ProductModel(
//     id: '1',
//     title: 'T-shirt',
//     price: 300,
//     imgUrl: AppAssets.tempProductAsset1,
//     category: 'Clothes',
//     discountValue: 20,
//   ),
// ];
