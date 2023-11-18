import 'dart:convert';
import 'dart:io';
import 'package:contact_app/src/core/constants/strings.dart';
import 'package:contact_app/src/core/network/api_response.dart';
import 'package:contact_app/src/core/storage/storage_keys.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../storage/storage_helper.dart';

class ApiHelper {
  static final ApiHelper _instance = ApiHelper
      ._internal(); // if we add _ before var then it become private
  factory ApiHelper() => _instance;

  ApiHelper._internal(); //another constructor should be private

  final Dio _dio = Dio(BaseOptions(
    contentType: 'application/json',
    baseUrl: 'http://dducusat.fluttertrainer.in/',
    connectTimeout: Duration(minutes: 2),
    receiveTimeout: Duration(minutes: 2),
  ));

  Future<ApiResponse> makeGetRequest(String route,
      {Map<String, dynamic>? header, Map<String,
          dynamic>? queryParameters}) async {
    try {
      Map<String, dynamic> defaultHeaders = await getEssentialHeaders();

      defaultHeaders.addAll(header ?? {});

      Response response = await _dio.get(
          route,
          queryParameters: queryParameters,
          options: Options(headers: defaultHeaders));


      return ApiResponse.fromJson(response.data);
    }
    catch (e) {
      return ApiResponse(status: false, error: Strings.apiResonseError);
    }
  }

  Future<ApiResponse> makePostRequest(String route,
      {Map<String, dynamic>? header,
        required Map<String, dynamic> body,
        Map<String, dynamic>? queryParameters}) async{
    try {
      Map<String, dynamic> defaultHeaders = await getEssentialHeaders();

      defaultHeaders.addAll(header ?? {});

      Response response = await _dio.post(
          route,
          data: jsonEncode(body),
          queryParameters: queryParameters,
          options: Options(headers:defaultHeaders));
      return ApiResponse.fromJson(response.data);
    }
    catch (e) {
      return const ApiResponse(status: false, error: 'Something went wrong');
    }

  }

  Future<ApiResponse> makePatchRequest(String route,
      {Map<String, dynamic>? header,
        required Map<String, dynamic> body,
        Map<String, dynamic>? queryParameters}) async{
    try {
      Map<String, dynamic> defaultHeaders = await getEssentialHeaders();

      defaultHeaders.addAll(header ?? {});

      Response response = await _dio.patch(
          route,
          queryParameters: queryParameters,
          data: jsonEncode(body),
          options: Options(headers: defaultHeaders));
      return ApiResponse.fromJson(response.data);
    }
    catch (e) {
      return const ApiResponse(status: false, error: 'Something went wrong');
    }

  }

  Future<ApiResponse> makeDeleteRequest(String route,
      {Map<String, dynamic>? header,
        Map<String, dynamic>? queryParameters}) async{
    try {
      Map<String, dynamic> defaultHeaders = await getEssentialHeaders();

      defaultHeaders.addAll(header ?? {});

      Response response = await _dio.patch(
          route,
          queryParameters: queryParameters,
          options: Options(headers: defaultHeaders));
      return ApiResponse.fromJson(response.data);
    }
    catch (e) {
      return const ApiResponse(status: false, error: 'Something went wrong');
    }
  }

  Future<Map<String, dynamic>> getEssentialHeaders() async {
     String? userToken = await StorageHelper().readData(StorageKeys.userToken);
    if(userToken == null){
      return {};
    }
      return {"Authorization": "Bearer $userToken"};

  }

  initDio(){
    _dio.interceptors.add(PrettyDioLogger());
  }



}