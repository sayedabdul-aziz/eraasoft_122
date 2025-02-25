import 'package:bookia/core/constants/constants.dart';
import 'package:bookia/core/services/local_storage.dart';
import 'package:bookia/feature/auth/data/models/request/register_params.dart';
import 'package:bookia/feature/auth/data/repo/auth_repo.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  register(RegisterParams params) {
    emit(AuthLoadingState());
    AuthRepo.register(params).then((value) {
      if (value != null) {
        AppLocalStorage.cacheData(AppConstants.kToken, value.data?.token);
        emit(AuthSuccessState());
      } else {
        emit(AuthErrorState(error: 'something went wrong'));
      }
    });
  }

  login(RegisterParams params) {
    emit(AuthLoadingState());
    AuthRepo.login(params).then((value) {
      if (value != null) {
        AppLocalStorage.cacheData(AppConstants.kToken, value.data?.token);
        emit(AuthSuccessState());
      } else {
        emit(AuthErrorState(error: 'something went wrong'));
      }
    });
  }
}
