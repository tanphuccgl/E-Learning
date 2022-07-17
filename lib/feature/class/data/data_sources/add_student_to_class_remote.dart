import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';

http.Client? client = http.Client();

Future<bool> addStudentToClass(
    {int? idClass,
    int? idStudent,
    Function? success,
    Function? failure}) async {
  var body = jsonEncode({
    'idClass': idClass,
    'idStudent': idStudent,
  });
  final response =
      await client?.post(Uri.parse('$mainUrl/class/AddStudentToClass'),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json" // k co header la failed 415
          },
          body: body);
  log("Post AddStudentToClass: " + "$mainUrl/class/AddStudentToClass");
  log("Post body AddStudentToClass: " + body);
  log("Response Json AddStudentToClass: ${json.decode(response!.body)}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
