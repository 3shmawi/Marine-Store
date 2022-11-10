import 'package:beauty_supplies_project/models/database_model.dart';
import 'package:beauty_supplies_project/models/product.dart';
import 'package:beauty_supplies_project/modules/search/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  List<ProductModel> resultSearch = [];
  List<ProductModel> allProducts = [];
  List<ProductModel> adminProducts = [];
  List<CartProductModel> cartProducts = [];

  void clearSearchResult() {
    resultSearch = [];
    emit(ClearSearchResultState());
  }

  void searchAtAllProducts(String search) {
    resultSearch = [];

    for (var element in allProducts) {
      if (element.title.toLowerCase().contains(search.toLowerCase()) ||
          element.description.contains(search)) resultSearch.add(element);
    }
    emit(ChangeSearchState());
  }

  void searchAtCartProducts(String search) {
    resultSearch = [];

    for (var element in cartProducts) {
      if (element.title.toLowerCase().contains(search.toLowerCase()) ||
          element.description.contains(search)) resultSearch.add(element);
    }
    emit(ChangeSearchState());
  }

  void searchAtAdminProducts(String search) {
    resultSearch = [];

    for (var element in adminProducts) {
      if (element.title.toLowerCase().contains(search.toLowerCase()) ||
          element.description.contains(search)) resultSearch.add(element);
    }
    emit(ChangeSearchState());
  }

  void getAllProducts(List<ProductModel> products) {
    allProducts = products;
    emit(GetAllProductsSearchState());
  }

  void getAdminProducts(List<ProductModel> products) {
    adminProducts = products;
    emit(GetAdminProductsSearchState());
  }

  void getCartProducts(List<CartProductModel> products) {
    cartProducts = products;
    emit(GetCartProductsSearchState());
  }
}
