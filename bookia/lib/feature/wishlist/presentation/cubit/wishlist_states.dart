class WishlistStates {}

class WishlistInitialState extends WishlistStates {}

class GetWishlistLoadingState extends WishlistStates {}

class GetWishlistSuccessState extends WishlistStates {}

class DeleteFromWishlistLoadingState extends WishlistStates {}

class DeleteFromWishlistSuccessState extends WishlistStates {}

class WishlistErrorState extends WishlistStates {
  final String error;

  WishlistErrorState({required this.error});
}
