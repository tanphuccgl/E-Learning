import 'dart:convert';
import 'dart:developer';


import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';

http.Client? client = http.Client();

Future<bool> addStudentToCourse({String? idStudent   , int? idCourse   ,Function? success,Function? failure}) async {
  var body = jsonEncode({'idStudent': idStudent, 'idCourse': idCourse ,});
  final response =
  await client?.post(Uri.parse('$mainUrl/course/AddStudent'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
      },
      body: body);
  log("Post AddStudent: " + "$mainUrl/course/AddStudent");
  log("Post body AddStudent: " + body);
  log("Response Json AddStudent: ${json.decode(response!.body)}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
