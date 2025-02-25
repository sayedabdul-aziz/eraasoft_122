import 'package:bookia/feature/home/data/models/best_sellers_response/best_sellers_response.dart';
import 'package:bookia/feature/home/data/repo/home_repo.dart';
import 'package:bookia/feature/home/presentation/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  BestSellersResponse? bestSellersResponse;

  bestSeller() {
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
}
