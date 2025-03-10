class CartStates {}

class CartInitialState extends CartStates {}

class GetCartLoadingState extends CartStates {}

class GetCartSuccessState extends CartStates {}

class DeleteAndUpdateCartLoadingState extends CartStates {}

class DeleteFromCartSuccessState extends CartStates {}

class UpdateCartSuccessState extends CartStates {}

class CartErrorState extends CartStates {
  final String error;

  CartErrorState({required this.error});
}
