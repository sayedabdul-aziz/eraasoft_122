import 'dart:developer';

import 'package:bookia/core/constants/constants.dart';
import 'package:bookia/core/constants/endpoints.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/core/services/local_storage.dart';
import 'package:bookia/feature/cart_list/data/models/get_cart_response/get_cart_responsee.dart';

class CartRepo {
  static Future<GetCartResponse?> getCart() async {
    try {
      var response = await DioProvider.get(
          endpoint: AppEndpoints.cart,
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppConstants.kToken)}"
          });
      if (response.statusCode == 200) {
        return GetCartResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> addToCart(int id) async {
    try {
      var response = await DioProvider.post(
          endpoint: AppEndpoints.addToCart,
          params: {
            "product_id": id
          },
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppConstants.kToken)}"
          });
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<GetCartResponse?> removeFromCart(int id) async {
    try {
      var response = await DioProvider.post(
          endpoint: AppEndpoints.removeFromCart,
          params: {
            "cart_item_id": id
          },
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppConstants.kToken)}"
          });
      if (response.statusCode == 200) {
        return GetCartResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<GetCartResponse?> updateCart(int id, int quantity) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.updateCart,
        params: {
          "cart_item_id": id,
          "quantity": quantity,
        },
        headers: {
          "Authorization":
              "Bearer ${AppLocalStorage.getData(AppConstants.kToken)}"
        },
      );
      if (response.statusCode == 201) {
        return GetCartResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
