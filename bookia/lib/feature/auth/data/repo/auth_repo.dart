import 'dart:developer';

import 'package:bookia/core/constants/endpoints.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/feature/auth/data/models/request/register_params.dart';
import 'package:bookia/feature/auth/data/models/response/user_response/user_response.dart';

class AuthRepo {
  static Future<UserResponse?> register(RegisterParams params) async {
    try {
      log(params.toJson().toString());
      var response = await DioProvider.post(
        endpoint: AppEndpoints.register,
        params: params.toJson(),
      );
      if (response.statusCode == 201) {
        return UserResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<UserResponse?> login(RegisterParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.login,
        params: params.toJson(),
      );
      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
