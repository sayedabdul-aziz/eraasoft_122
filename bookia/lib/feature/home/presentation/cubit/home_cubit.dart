import 'package:bookia/feature/cart_list/data/repo/cart_repo.dart';
import 'package:bookia/feature/home/data/models/best_sellers_response/best_sellers_response.dart';
import 'package:bookia/feature/home/data/models/get_slider_response/get_slider_response.dart';
import 'package:bookia/feature/home/data/repo/home_repo.dart';
import 'package:bookia/feature/home/presentation/cubit/home_states.dart';
import 'package:bookia/feature/wishlist/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  BestSellersResponse? bestSellersResponse;
  GetSliderResponse? sliderResponse;

  getBestSeller() {
    emit(BestSellerLoadingState());
    HomeRepo.getBestSellers().then((value) {
      if (value != null) {
        bestSellersResponse = value;
        emit(BestSellerSuccessState());
      } else {
        emit(BestSellerErrorState(error: 'something went wrong'));
      }
    });
  }

  getSlider() {
    emit(SliderLoadingState());
    HomeRepo.getSlider().then((value) {
      if (value != null) {
        sliderResponse = value;
        emit(SliderSuccessState());
      } else {
        emit(SliderErrorState(error: 'something went wrong'));
      }
    });
  }

  addToWishlist(int id) {
    emit(AddToWishListCartLoadingState());
    WishlistRepo.addToWishlist(id).then((value) {
      if (value) {
        emit(AddToWishListCartSuccessState(message: 'Added to wishlist'));
      } else {
        emit(AddToWishListCartErrorState(error: 'something went wrong'));
      }
    });
  }

  addToCart(int id) {
    emit(AddToWishListCartLoadingState());
    CartRepo.addToCart(id).then((value) {
      if (value) {
        emit(AddToWishListCartSuccessState(message: 'Added to cart'));
      } else {
        emit(AddToWishListCartErrorState(error: 'something went wrong'));
      }
    });
  }

  // getHomeData() {
  //   emit(HomeLoadingState());

  //   Future.wait([
  //     HomeRepo.getBestSellers(),
  //     HomeRepo.getSlider(),
  //   ]).then((responses) {
  //     final bestSellers = responses[0];
  //     final slider = responses[1];

  //     if (bestSellers != null && slider != null) {
  //       bestSellersResponse = bestSellers;
  //       sliderResponse = slider;
  //       emit(HomeSuccessState());
  //     } else {
  //       emit(HomeErrorState(error: 'Something went wrong'));
  //     }
  //   }).catchError((error) {
  //     emit(HomeErrorState(error: error.toString()));
  //   });
  // }
}
