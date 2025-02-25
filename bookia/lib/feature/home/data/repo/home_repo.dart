import 'dart:developer';

import 'package:bookia/core/constants/endpoints.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/feature/home/data/models/best_sellers_response/best_sellers_response.dart';

class HomeRepo {
  static Future<BestSellersResponse?> getBestSellers() async {
    try {
      var response = await DioProvider.get(
        endpoint: AppEndpoints.bestSellers,
      );
      if (response.statusCode == 200) {
        return BestSellersResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
