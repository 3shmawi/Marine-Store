abstract class SearchState {}

class SearchInitial extends SearchState {}

class ChangeSearchState extends SearchState {}

class GetAllProductsSearchState extends SearchState {}

class GetAdminProductsSearchState extends SearchState {}

class GetCartProductsSearchState extends SearchState {}
class ClearSearchResultState extends SearchState {}
