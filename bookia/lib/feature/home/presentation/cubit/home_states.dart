class HomeStates {}

class HomeInitialState extends HomeStates {}

class BestSellerLoadingState extends HomeStates {}

class BestSellerSuccessState extends HomeStates {}

class BestSellerErrorState extends HomeStates {
  final String error;

  BestSellerErrorState({required this.error});
}
