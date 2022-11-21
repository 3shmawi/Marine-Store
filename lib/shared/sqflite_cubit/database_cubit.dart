import 'package:beauty_supplies_project/models/database_model.dart';
import 'package:beauty_supplies_project/services/local_database.dart';
import 'package:beauty_supplies_project/utilities/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'database_state.dart';

class DatabaseCubit extends Cubit<DatabaseState> {
  DatabaseCubit() : super(DatabaseInitial());

  List<CartProductModel> cart = [];
  List<FavProductModel> fav = [];

  final EcommerceDatabase _database = EcommerceDatabase.instance;

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
      getSumOfAllCartProductPrice();
      getWhatsAppMessage();
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

  double allCartProductsPrice = 0.0;

  void getSumOfAllCartProductPrice() {
    allCartProductsPrice = 0.0;
    for (var element in cart) {
      allCartProductsPrice += getPriceAfterDiscount(
              element.price.toDouble(), element.discountValue!.toDouble()) *
          element.count;
    }
    emit(GetSumOfAllCartProductsPriceState());
  }

  double discountPrice = 0.0;

  double getPriceAfterDiscount(double price, double discountValue) {
    if (discountValue == 0) {
      emit(GetPriceAfterDiscountState());
      return price;
    } else {
      emit(GetPriceAfterDiscountState());
      return (price - price * (discountValue / 100));
    }
  }

  void deleteDatabase() {
    for (var element in cart) {
      deleteFromCartDataBase(element.dbId!);
    }

    for (var element in fav) {
      deleteFromFavDataBase(element.dbId!);
    }
    emit(DeleteLocalDatabaseState());
  }

  String whatsAppMessage = 'Hello i\'ve an order\n';

  void getWhatsAppMessage() {
    whatsAppMessage = '';
    whatsAppMessage = 'Hello i\'ve an order\n';
    for (int i = 0; i < cart.length; i++) {
      whatsAppMessage +=
          '\n${i + 1})\nCategory: ${cart[i].category}\nName: ${cart[i].title}\nPrice: ${getTwoDecimalDouble(getPriceAfterDiscount(cart[i].price.toDouble(), cart[i].discountValue!.toDouble()).toString())} E.g\nCount: ${cart[i].count}\n';
    }
    whatsAppMessage +=
        '\n*Total Price: ${getTwoDecimalDouble(allCartProductsPrice.toString())} E.g*\n';

    emit(WhatsAppMessageState());
  }
}
