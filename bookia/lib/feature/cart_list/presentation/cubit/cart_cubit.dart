import 'package:bookia/feature/cart_list/data/models/get_cart_response/get_cart_responsee.dart';
import 'package:bookia/feature/cart_list/data/repo/cart_repo.dart';
import 'package:bookia/feature/cart_list/presentation/cubit/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  GetCartResponse? cartResponse;

  getCart() async {
    emit(GetCartLoadingState());
    await CartRepo.getCart().then((value) {
      if (value != null) {
        cartResponse = value;
        emit(GetCartSuccessState());
      } else {
        emit(CartErrorState(error: 'Something went wrong'));
      }
    });
  }

  deleteFromCart(int id) async {
    emit(DeleteAndUpdateCartLoadingState());
    await CartRepo.removeFromCart(id).then((value) {
      if (value != null) {
        cartResponse = value;
        emit(DeleteFromCartSuccessState());
      } else {
        emit(CartErrorState(error: 'Something went wrong'));
      }
    });
  }

  updateCart(int id, int quantity) async {
    emit(DeleteAndUpdateCartLoadingState());
    await CartRepo.updateCart(id, quantity).then((value) {
      if (value != null) {
        cartResponse = value;
        emit(UpdateCartSuccessState());
      } else {
        emit(CartErrorState(error: 'Something went wrong'));
      }
    });
  }
}
