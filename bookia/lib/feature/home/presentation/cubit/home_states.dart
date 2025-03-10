class HomeStates {}

class HomeInitialState extends HomeStates {}

class BestSellerLoadingState extends HomeStates {}

class BestSellerSuccessState extends HomeStates {}

class SliderLoadingState extends HomeStates {}

class SliderSuccessState extends HomeStates {}

class AddToWishListCartLoadingState extends HomeStates {}

class AddToWishListCartSuccessState extends HomeStates {
  final String message;

  AddToWishListCartSuccessState({required this.message});
}

class AddToWishListCartErrorState extends HomeStates {
  final String error;

  AddToWishListCartErrorState({required this.error});
}

class BestSellerErrorState extends HomeStates {
  final String error;

  BestSellerErrorState({required this.error});
}

class SliderErrorState extends HomeStates {
  final String error;

  SliderErrorState({required this.error});
}
