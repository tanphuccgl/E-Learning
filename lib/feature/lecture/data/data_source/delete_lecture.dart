import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

http.Client? client = http.Client();

Future<bool> removeLecture(
    {int? idLecture, Function? success, Function? failure}) async {
  var body = jsonEncode({
    'idLecture': idLecture,
  });
  final response = await client?.delete(
      Uri.parse('$mainUrl/lecture/DeleteLecture/$idLecture'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "auth-token": "${appUser?.token}",
        // k co header la failed 415
      },
      body: body);
  log("delete removeLecture: " + "$mainUrl/lecture/DeleteLecture/$idLecture");
  log("delete body removeLecture: " + body);
  log("Response Json removeLecture: ${json.decode(response!.body)}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
