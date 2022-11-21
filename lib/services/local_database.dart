import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:beauty_supplies_project/models/database_model.dart';
import 'package:sqflite/sqflite.dart';

class EcommerceDatabase {
  static final EcommerceDatabase instance = EcommerceDatabase._init();

  static Database? _database;

  EcommerceDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('ecommerce.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart (dbId INTEGER PRIMARY KEY, title TEXT, description TEXT, imgUrl TEXT, category TEXT, price INTEGER, id TEXT, rate INTEGER, discountValue INTEGER, count INTEGER)');
    await db.execute(
        'CREATE TABLE favorite (dbId INTEGER PRIMARY KEY, title TEXT, description TEXT, imgUrl TEXT, category TEXT, price INTEGER, id TEXT, rate INTEGER, discountValue INTEGER)');
  }

  Future<CartProductModel> insertDataToCartDataBase({
    required CartProductModel product,
  }) async {
    final db = await instance.database;

    final id = await db.insert('cart', product.toMap());
    return product.copy(dbId: id);
  }

  Future<FavProductModel> insertDataToFavoriteDatabase({
    required FavProductModel product,
  }) async {
    final db = await instance.database;

    final id = await db.insert('favorite', product.toMap());
    if (kDebugMode) {
      print('id of database is =>>>>>>>>>  $id');
    }
    return product.copy(dbId: id);
  }

  // Future<ProductDatabaseModel> readCartProduct({
  //   required int id,
  // }) async {
  //   final db = await instance.database;
  //
  //   final maps = await db.query(
  //     'cart',
  //     columns: ProductFields.values,
  //     where: '${ProductFields.dbId} = ?',
  //     whereArgs: [id],
  //   );
  //
  //   if (maps.isNotEmpty) {
  //     return ProductDatabaseModel.fromJson(maps.first);
  //   } else {
  //     throw Exception('ID $id not found');
  //   }
  // }

  // Future<ProductDatabaseModel> readFavoriteProduct({
  //   required int id,
  // }) async {
  //   final db = await instance.database;
  //
  //   final maps = await db.query(
  //     'favorite',
  //     columns: ProductFields.values,
  //     where: '${ProductFields.dbId} = ?',
  //     whereArgs: [id],
  //   );
  //
  //   if (maps.isNotEmpty) {
  //     return ProductDatabaseModel.fromJson(maps.first);
  //   } else {
  //     throw Exception('ID $id not found');
  //   }
  // }

  Future<List<CartProductModel>> readAllEcommerceCartData() async {
    final db = await instance.database;

    final result = await db.rawQuery('SELECT * FROM cart');

    return result
        .map((json) => CartProductModel.fromMapWithoutId(json))
        .toList();
  }

  Future<List<FavProductModel>> readAllEcommerceFavoriteData() async {
    final db = await instance.database;

    final result = await db.rawQuery('SELECT * FROM favorite');

    return result
        .map((json) => FavProductModel.fromMapWithoutId(json))
        .toList();
  }

  Future<int> updateCartProduct({
    required CartProductModel product,
  }) async {
    final db = await instance.database;

    return db.update(
      'cart',
      product.toMap(),
      where: '${ProductFields.dbId} = ?',
      whereArgs: [product.dbId],
    );
  }

  Future<int> updateFavoriteProduct({
    required FavProductModel product,
  }) async {
    final db = await instance.database;

    return db.update(
      'favorite',
      product.toMap(),
      where: '${ProductFields.dbId} = ?',
      whereArgs: [product.dbId],
    );
  }

  Future<int> deleteCartProduct({
    required int id,
  }) async {
    final db = await instance.database;

    return await db.delete(
      'cart',
      where: '${ProductFields.dbId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteFavoriteProduct({
    required int id,
  }) async {
    final db = await instance.database;

    return await db.delete(
      'favorite',
      where: '${ProductFields.dbId} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ecommerce.db');
    await deleteDatabase(path);
    db.close();
  }

  Future delete() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ecommerce.db');
    await deleteDatabase(path);

  }
}
