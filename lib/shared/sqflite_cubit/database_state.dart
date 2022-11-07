abstract class DatabaseState {}

class DatabaseInitial extends DatabaseState {}

//insert
class InsertToCartLocalDatabaseLoadingState extends DatabaseState {}

class InsertToCartLocalDatabaseSuccessState extends DatabaseState {}

class InsertToCartLocalDatabaseErrorState extends DatabaseState {}

class InsertToFavLocalDatabaseLoadingState extends DatabaseState {}

class InsertToFavLocalDatabaseSuccessState extends DatabaseState {}

class InsertToFavLocalDatabaseErrorState extends DatabaseState {}

//update
class UpdateCartLocalDatabaseLoadingState extends DatabaseState {}

class UpdateCartLocalDatabaseSuccessState extends DatabaseState {}

class UpdateCartLocalDatabaseErrorState extends DatabaseState {}

class UpdateFavLocalDatabaseLoadingState extends DatabaseState {}

class UpdateFavLocalDatabaseSuccessState extends DatabaseState {}

class UpdateFavLocalDatabaseErrorState extends DatabaseState {}

//delete
class DeleteFromCartLocalDatabaseLoadingState extends DatabaseState {}

class DeleteFromCartLocalDatabaseSuccessState extends DatabaseState {}

class DeleteFromCartLocalDatabaseErrorState extends DatabaseState {}

class DeleteFromFavLocalDatabaseLoadingState extends DatabaseState {}

class DeleteFromFavLocalDatabaseSuccessState extends DatabaseState {}

class DeleteFromFavLocalDatabaseErrorState extends DatabaseState {}

//get all data
class GetAllDataFromCartLocalDatabaseLoadingState extends DatabaseState {}

class GetAllDataFromCartLocalDatabaseSuccessState extends DatabaseState {}

class GetAllDataFromCartLocalDatabaseErrorState extends DatabaseState {}

class GetAllDataFromFavLocalDatabaseLoadingState extends DatabaseState {}

class GetAllDataFromFavLocalDatabaseSuccessState extends DatabaseState {}

class GetAllDataFromFavLocalDatabaseErrorState extends DatabaseState {}

//change state
class ChangeFavoriteState extends DatabaseState {}

class ChangeCartState extends DatabaseState {}
