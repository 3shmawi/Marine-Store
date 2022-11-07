import 'package:beauty_supplies_project/models/database_model.dart';
import 'package:beauty_supplies_project/services/local_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product.dart';
import 'database_state.dart';

class DatabaseCubit extends Cubit<DatabaseState> {
  DatabaseCubit() : super(DatabaseInitial());

  List<CartProductModel> cart = [];
  List<FavProductModel> fav = [];

  final EcommerceCartDatabase _database = EcommerceCartDatabase.instance;

  // inset to database
  void insertToCartDataBase(CartProductModel productModel) {
    emit(InsertToCartLocalDatabaseLoadingState());
    _database.insertDataToCartDataBase(product: productModel).then((value) {
      getAllDataFromCartDataBase();
      emit(InsertToCartLocalDatabaseSuccessState());
    }).catchError((error) {
      emit(InsertToCartLocalDatabaseErrorState());
    });
  }

  void insertToFavDataBase(FavProductModel productModel) {
    emit(InsertToFavLocalDatabaseLoadingState());
    _database.insertDataToFavoriteDatabase(product: productModel).then((value) {
      if (kDebugMode) {
        print(value.imgUrl);
        print('Successfully ........................');
      }
      getAllDataFromFavDataBase();
      emit(InsertToFavLocalDatabaseSuccessState());
    }).catchError((error) {
      emit(InsertToFavLocalDatabaseErrorState());
    });
  }

  //update data

  void updateCartDataBase(CartProductModel productModel) {
    emit(UpdateCartLocalDatabaseLoadingState());
    _database.updateCartProduct(product: productModel).then((value) {
      getAllDataFromCartDataBase();
      emit(UpdateCartLocalDatabaseSuccessState());
    }).catchError((error) {
      emit(UpdateCartLocalDatabaseErrorState());
    });
  }

  void updateFavDataBase(FavProductModel productModel) {
    emit(UpdateFavLocalDatabaseLoadingState());
    _database.updateFavoriteProduct(product: productModel).then((value) {
      getAllDataFromFavDataBase();
      emit(UpdateFavLocalDatabaseSuccessState());
    }).catchError((error) {
      emit(UpdateFavLocalDatabaseErrorState());
    });
  }

  //delete data

  void deleteFromCartDataBase(int id) {
    emit(DeleteFromCartLocalDatabaseLoadingState());
    _database.deleteCartProduct(id: id).then((value) {
      getAllDataFromCartDataBase();
      emit(DeleteFromCartLocalDatabaseSuccessState());
    }).catchError((error) {
      emit(DeleteFromCartLocalDatabaseErrorState());
    });
  }

  void deleteFromFavDataBase(int id) {
    emit(DeleteFromFavLocalDatabaseLoadingState());
    _database.deleteFavoriteProduct(id: id).then((value) {
      getAllDataFromFavDataBase();
      emit(DeleteFromFavLocalDatabaseSuccessState());
    }).catchError((error) {
      emit(DeleteFromFavLocalDatabaseErrorState());
    });
  }

  //get all data
  void getAllDataFromCartDataBase() {
    emit(GetAllDataFromCartLocalDatabaseLoadingState());
    _database.readAllEcommerceCartData().then((value) {
      cart = [];
      cart = value;
      emit(GetAllDataFromCartLocalDatabaseSuccessState());
    }).catchError((error) {
      emit(GetAllDataFromCartLocalDatabaseErrorState());
    });
  }

  void getAllDataFromFavDataBase() {
    emit(GetAllDataFromFavLocalDatabaseLoadingState());
    _database.readAllEcommerceFavoriteData().then((value) {
      fav = [];
      fav = value;
      emit(GetAllDataFromFavLocalDatabaseSuccessState());
    }).catchError((error) {
      emit(GetAllDataFromFavLocalDatabaseErrorState());
    });
  }

  //
  // List<ProductModel> products = [];
  //
  // void changeProducts(List<ProductModel> newProduct){
  //   products =newProduct;
  //   emit(ChangeState());
  // }
  // String image(String id) {
  //   for (var element in products) {
  //     if (element.id == id) return element.imgUrl;
  //   }
  //   return 'https://images.unsplash.com/photo-1663214532892-57aac8c5149f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1Nnx8fGVufDB8fHx8&auto=format&fit=crop&w=400&q=60';
  // }

  // bool isFav = false;
  //
  // void changeFavState(FavProductModel product) {
  //   if (isFavorite(product.id)) {
  //     insertToFavDataBase(product);
  //   } else {
  //     int? dId = product.dbId;
  //     if (dId != null) {
  //       deleteFromFavDataBase(dId);
  //     }
  //   }
  // }

  void favoriteButton(FavProductModel favProductModel) {
    int i = 0;
    for (i = 0; i < fav.length; i++) {
      if (fav[i].id.contains(favProductModel.id)) {
        break;
      }
    }
    if (i == fav.length) {
      insertToFavDataBase(favProductModel);
    } else {
      deleteFromFavDataBase(fav[i].dbId!);
    }
    emit(ChangeFavoriteState());
  }

  bool isFav(FavProductModel favProductModel) {
    int i = 0;
    for (i = 0; i < fav.length; i++) {
      if (fav[i].id.contains(favProductModel.id)) {
        break;
      }
    }
    if (i == fav.length) {
      emit(ChangeFavoriteState());

      return false;
    } else {
      emit(ChangeFavoriteState());

      return true;
    }
  }

  void cartButton(CartProductModel cartProduct) {
    int i = 0;
    for (i = 0; i < cart.length; i++) {
      if (cart[i].id.contains(cartProduct.id)) {
        break;
      }
    }
    if (i == cart.length) {
      insertToCartDataBase(cartProduct);
    } else {
      deleteFromCartDataBase(cart[i].dbId!);
    }
    emit(ChangeCartState());
  }

  bool isCart(CartProductModel cartProduct) {
    int i = 0;
    for (i = 0; i < cart.length; i++) {
      if (cart[i].id.contains(cartProduct.id)) {
        break;
      }
    }
    if (i == cart.length) {
      emit(ChangeCartState());

      return false;
    } else {
      emit(ChangeCartState());

      return true;
    }
  }
}
