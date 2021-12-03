import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

http.Client? client = http.Client();

Future<bool> changeInfoUser(
    {String? fullName,
    String? address,
    String? email,
    String? gender,
    int? idClass,
    String? nameClass,
    String? parentName,
    String? phoneNumber,
    String? phoneNumberParent,
    Function? success,
    Function? failure}) async {
  var body = jsonEncode({
    'fullName': fullName,
    'address': address,
    'email': email,
    'gender': gender,
    'idClass': idClass,
    'nameClass': nameClass,
    'parentName': parentName,
    'phoneNumber': phoneNumber,
    'phoneNumberParent': phoneNumberParent
  });
  final response =
      await client?.put(Uri.parse('$mainUrl/account/ChangeInformation'),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            "auth-token": "${appUser?.token}" // k co header la failed 415
          },
          body: body);
  log("Post changeInfoUser: " + "$mainUrl/account/ChangeInformation");
  log("Post body changeInfoUser: " + body);
  log("Response Json changeInfoUser: ${json.decode(response!.body)}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
