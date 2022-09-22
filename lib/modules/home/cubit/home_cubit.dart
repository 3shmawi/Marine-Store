import 'package:beauty_supplies_project/models/cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<String> fav = [];

  void changeFavoriteState(String image) {
    if (fav.contains(image)) {
      removeProductFromFavorite(image);
    } else {
      addProductToFavorite(image);
    }

    emit(ChangeFavState());
  }

  void addProductToFavorite(String image) {
    fav.add(image);
  }

  void removeProductFromFavorite(String image) {
    fav.remove(image);
  }

  List<CartModel> cart = [];

  void changeCartState(CartModel cartModel) {
    if (cart.contains(cartModel)) {
      removeProductFromCart(cartModel);
    } else {
      addProductToCart(cartModel);
    }

    emit(ChangeCartState());
  }

  void addProductToCart(CartModel cartModel) {
    cart.add(cartModel);
  }

  void removeProductFromCart(CartModel cartModel) {
    cart.remove(cartModel);
  }

  void changeCountOfProductNumberInc(int index) {
    cart[index].number += 1;
    emit(ChangeCartNumberCountIncState());
  }

  void changeCountOfProductNumberDEc(int index) {
    cart[index].number -= 1;
    emit(ChangeCartNumberCountDecState());
  }
}
