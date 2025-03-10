import 'package:bookia/feature/wishlist/data/models/get_wishlist_response/get_wishlist_response.dart';
import 'package:bookia/feature/wishlist/data/repo/wishlist_repo.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistStates> {
  WishlistCubit() : super(WishlistInitialState());

  GetWishlistResponse? wishlistResponse;

  getWishlist() {
    emit(GetWishlistLoadingState());
    WishlistRepo.getWishlist().then((value) {
      if (value != null) {
        wishlistResponse = value;
        emit(GetWishlistSuccessState());
      } else {
        emit(WishlistErrorState(error: 'Something went wrong'));
      }
    });
  }

  deleteFromWishlist(int id) {
    emit(DeleteFromWishlistLoadingState());
    WishlistRepo.removeFromWishlist(id).then((value) {
      if (value != null) {
        wishlistResponse = value;
        emit(DeleteFromWishlistSuccessState());
      } else {
        emit(WishlistErrorState(error: 'Something went wrong'));
      }
    });
  }
}
