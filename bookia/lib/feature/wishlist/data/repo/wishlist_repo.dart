import 'dart:developer';

import 'package:bookia/core/constants/constants.dart';
import 'package:bookia/core/constants/endpoints.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/core/services/local_storage.dart';
import 'package:bookia/feature/wishlist/data/models/get_wishlist_response/get_wishlist_response.dart';

class WishlistRepo {
  static Future<GetWishlistResponse?> getWishlist() async {
    try {
      var response = await DioProvider.get(
          endpoint: AppEndpoints.wishlist,
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppConstants.kToken)}"
          });
      if (response.statusCode == 200) {
        return GetWishlistResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> addToWishlist(int id) async {
    try {
      var response = await DioProvider.post(
          endpoint: AppEndpoints.addToWishlist,
          params: {
            "product_id": id
          },
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppConstants.kToken)}"
          });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<GetWishlistResponse?> removeFromWishlist(int id) async {
    try {
      var response = await DioProvider.post(
          endpoint: AppEndpoints.removeFromWishlist,
          params: {
            "product_id": id
          },
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppConstants.kToken)}"
          });
      if (response.statusCode == 200) {
        return GetWishlistResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
