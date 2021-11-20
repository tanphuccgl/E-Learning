import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/data/models/login_data.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/data/models/login_response_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginData> login(String email, String pass);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client? client;

  LoginRemoteDataSourceImpl({@required this.client});

  @override
  Future<LoginData> login(String email, String pass) {
    return _login(email, pass);
  }

  Future<LoginData> _login(String email, String pass) async {
    var body = jsonEncode({'username': email, 'password': pass});
    final response = await client
        ?.post(Uri.parse('http://api.itcode.vn:3000/account/Login'),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json" // k co header la failed 415
              //'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: body)
        .timeout(Duration(seconds: 15));
    log("Post Login: " + "http://149.28.129.166:3000/account/Login");
    log("Post body Login: " + body);
    log("Response Json Login: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success = LoginResponseModel.fromJson(json.decode(response.body));

      return success.data!;
    } else {
      throw ServerException();
    }
  }
}
