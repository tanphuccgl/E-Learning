import 'dart:convert';
import 'dart:developer';


import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

http.Client? client = http.Client();

Future<bool> addCourse({String? nameCourse  , int? idTeacher  ,Function? success,Function? failure}) async {
  var body = jsonEncode({'nameCourse': nameCourse, 'idTeacher': idTeacher ,});
  final response =
  await client?.post(Uri.parse('$mainUrl/course/AddCourse'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" ,
        "auth-token":"${appUser?.token}"// k co header la failed 415
      },
      body: body);
  log("Post AddCourse: " + "$mainUrl/course/AddCourse");
  log("Post body AddCourse: " + body);
  log("Response Json AddCourse: ${json.decode(response!.body)}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
