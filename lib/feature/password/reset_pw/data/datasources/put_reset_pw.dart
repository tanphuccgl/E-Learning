import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

http.Client? client = http.Client();

Future<bool> putResetPw(
    {int? idAccount, Function()? success, Function? failure}) async {

  final response = await client?.put(
      Uri.parse('$mainUrl/Account/ResetPasswordForAdmin/$idAccount'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "auth-token" : "${appUser?.token}",
        // k co header la failed 415
      },
     );

  log("status putResetPw: ${response!.statusCode}");
  log("${json.decode(response.body)}");

String decode= json.decode(response.body).toString();
 String newPw= decode.substring(10,16).toString();
  prefs?.remove("resetpw");
 prefs?.setString("resetpw", newPw);
  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
