import 'dart:convert';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';

http.Client? client = http.Client();

Future<bool> addExercise({String? titleExercise , String? idCourse,String? descriptionExercise,
  DateTime? allowSubmission, DateTime? submissionDeadline,FilePicker? files,
  Function? success,Function? failure}) async {
  var body = jsonEncode({'titleExercise': titleExercise, 'lv': idCourse,'descriptionExercise': descriptionExercise,
    'allowSubmission': allowSubmission,'submissionDeadline': submissionDeadline, 'files': files});
  final response =
  await client?.post(Uri.parse('$mainUrl/class/AddClass'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
      },
      body: body);
  log("Post AddClass: " + "$mainUrl/class/AddClass");
  log("Post body AddClass: " + body);
  log("Response Json AddClass: ${json.decode(response!.body)}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
