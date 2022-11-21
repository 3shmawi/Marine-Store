abstract class AdminUploadProductViewState {}

class AdminViewInitialState extends AdminUploadProductViewState {}

class AdminViewPickedImagesSuccessState extends AdminUploadProductViewState {}

class AdminViewPickedImageErrorState extends AdminUploadProductViewState {}

class AdminViewPostProductAtAdminPathLoadingState
    extends AdminUploadProductViewState {}

class AdminViewPostProductAtAdminPathSuccessState
    extends AdminUploadProductViewState {}

class AdminViewPostProductAtAdminPathErrorState
    extends AdminUploadProductViewState {}



class AdminViewPostProductAtProductsPathErrorState
    extends AdminUploadProductViewState {}

class AdminViewPostProductAtCategoryPathErrorState
    extends AdminUploadProductViewState {}

class AdminViewChangeSelectedCategoryState extends AdminUploadProductViewState {
}

class AdminViewResetImageState extends AdminUploadProductViewState {}

class AdminViewCreateNewIdState extends AdminUploadProductViewState {}
