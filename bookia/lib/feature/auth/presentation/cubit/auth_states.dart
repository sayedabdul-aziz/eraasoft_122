class AuthStates {}

class AuthInitialState extends AuthStates {}

// register
class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final String error;

  AuthErrorState({required this.error});
}
