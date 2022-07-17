import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

http.Client? client = http.Client();

Future<bool> changePassword(
    {String? password,
    String? newpassword,
    Function? success,
    Function? failure}) async {
  var body = jsonEncode({
    'password': password,
    'newpassword': newpassword,
    "idAccount": appUser?.iId
  });
  final response =
      await client?.put(Uri.parse('$mainUrl/account/ChangePassword'),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            "auth-token": "${appUser?.token}" // k co header la failed 415
          },
          body: body);
  log("Post ChangePassword: " + "$mainUrl/account/ChangePassword");
  log("Post body ChangePassword: " + body);
  log("Response Json ChangePassword: ${json.decode(response!.body)}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
