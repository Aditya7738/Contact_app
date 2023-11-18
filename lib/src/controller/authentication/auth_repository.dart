import 'dart:async';
import 'dart:async';
import 'dart:collection';
import 'package:contact_app/src/core/network/api_response.dart';
import 'package:contact_app/src/core/network/apihelper.dart';
import 'package:contact_app/src/models/signupModel.dart';
import 'package:dio/dio.dart';



class AuthRepository {
  // Map<String, String> credential(){
  //   Map<String, String> map = new Map<String, String>();
  //
  //   var email = "adityashigwan773@gmail.com";
  //   var password = "123456";
  //
  //   return map;
  // }

  Future<ApiResponse> login(String email, String password) async {
    ApiResponse apiResponse = await ApiHelper().makePostRequest("user/login",
        body: {"email": email, "password": password});
    return apiResponse;
  }

  Future<ApiResponse> signup(SignupModel signupModel) async{

    ApiResponse apiResponse = await ApiHelper().makePostRequest("user/signup",
        body: signupModel.toJson());

    return apiResponse;
  }



  // Future<bool>(String email, String password) async {
  //   if (email == 'adityashigwan773@gmail.com' && password == 'Aditya@123') {
  //     return true;
  //   }
  //   return false;
  // }
}
