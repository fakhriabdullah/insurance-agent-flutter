import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:insurance_agent_flutter/model/coveragerisk/coverage_risk_response.dart';
import 'package:insurance_agent_flutter/model/offer/add_offer_response.dart';
import 'package:insurance_agent_flutter/model/offer/offer_detail_response.dart';
import 'package:insurance_agent_flutter/model/offer/offer_response.dart';
import 'package:insurance_agent_flutter/util/api_client.dart';
import 'package:insurance_agent_flutter/util/secure_storage_utils.dart';

class OfferRepository {
  Dio api = Client().init();
  Future<CoverageRiskResponse?> getCoverageRisk() async {
    try {
      var token = await SecureStorageUtils.getToken();
      var response = await api.get(
        "/coverage-risk",
        options:
            Options(contentType: Headers.formUrlEncodedContentType, headers: {
          "Authorization": "Bearer $token",
        }),
      );
      return CoverageRiskResponse.fromJson(jsonDecode(response.toString()));
    } on DioException catch (ex) {
      String errorMessage = jsonDecode(ex.response.toString())["message"];
      throw Exception(errorMessage);
    }
  }

  Future<AddOfferResponse?> addOffer(Map<String, dynamic> params) async {
    try {
      var token = await SecureStorageUtils.getToken();
      var response = await api.post("/offer",
          options: Options(
            contentType: Headers.jsonContentType,
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
          data: params);
      return AddOfferResponse.fromJson(jsonDecode(response.toString()));
    } on DioException catch (ex) {
      String errorMessage = jsonDecode(ex.response.toString())["message"];
      throw Exception(errorMessage);
    }
  }

  Future<OfferResponse?> getOffer(int page) async {
    try {
      var token = await SecureStorageUtils.getToken();
      var response = await api.get("/offer",
          options: Options(
            contentType: Headers.jsonContentType,
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
          queryParameters: {"page": page});
      return OfferResponse.fromJson(jsonDecode(response.toString()));
    } on DioException catch (ex) {
      String errorMessage = jsonDecode(ex.response.toString())["message"];
      throw Exception(errorMessage);
    }
  }

  Future<OfferDetailResponse?> getOfferDetail(int id) async {
    try {
      var token = await SecureStorageUtils.getToken();
      var response = await api.get(
        "/offer/$id",
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return OfferDetailResponse.fromJson(jsonDecode(response.toString()));
    } on DioException catch (ex) {
      String errorMessage = jsonDecode(ex.response.toString())["message"];
      throw Exception(errorMessage);
    }
  }
}
