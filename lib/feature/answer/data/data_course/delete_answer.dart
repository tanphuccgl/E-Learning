import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

http.Client? client = http.Client();

Future<bool> removeAnswer(
    {int? idAnswer, Function? success, Function? failure}) async {
  var body = jsonEncode({
    'idAnswer': idAnswer,
  });
  final response =
      await client?.delete(Uri.parse('$mainUrl/answer/DeleteAnswer/$idAnswer'),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            "auth-token": "${appUser?.token}",
            // k co header la failed 415
          },
          body: body);
  log("delete removeAnswer: " + "$mainUrl/answer/DeleteAnswer/$idAnswer");
  log("delete body removeAnswer: " + body);
  log("Response Json removeAnswer: ${json.decode(response!.body)}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
