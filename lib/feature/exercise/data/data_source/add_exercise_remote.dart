import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/config/get_current_user.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';

http.Client? client = http.Client();

Future<bool> addExercise(
    {String? titleExercise,
    String? idCourse,
    String? descriptionExercise,
    String? allowSubmission,
    String? submissionDeadline,
    List<PlatformFile>? listFile,
    Function? success,
    Function? failure}) async {


  var uri = Uri.parse('$mainUrl/exercise/AddExercise');
  var request = http.MultipartRequest('POST', uri);
  request.headers["Accept"]="application/json";
  request.headers["auth-token"]="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2Mzc0NDMxODYsIl9pZCI6MiwiaWF0IjoxNjM3NDM5NTg2fQ.46j9SOESbLwbnQPvAbvvEra5FonjAbV0jqT_oBluyTg";
  request.headers["Content-Type"]="multipart/form-data";
request.fields["files"]="files";
  request.fields['idCourse'] = 'eb5f9ca4-0d73-4dbb-a28a-03dc76e5cdb6';
    for(var item in listFile!)
      {
        var file=await http.MultipartFile.fromPath("files", item.path!);
        request.files.add(file);
      }


var response = await request.send();
var a=await response.stream.toBytes();
var b=String.fromCharCodes(a);
  print(b.toString());


  var formData = FormData();
  //print("aa ${files!.path}");
  // http.MultipartFile multi =
  //     await http.MultipartFile.fromPath("files", files.path!);
  var body = jsonEncode({
    'titleExercise': "deqw",
    'idCourse': "eb5f9ca4-0d73-4dbb-a28a-03dc76e5cdb6",
    'descriptionExercise': "descriptionExercise",
    "isTextPoint": 1,
    'allowSubmission': DateTime.now().toString(),
    'submissionDeadline': DateTime.now().toString(),
   // "files": formData.files.,
  });

  final response1 =
      await client?.post(Uri.parse('$mainUrl/exercise/AddExercise'),
          headers: {
            "Accept": "application/json",
            //   "content-type": "application/json" ,// k co header la failed 415
            'auth-token':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleH'
                    'AiOjE2Mzc0MzkwMDgsIl9pZCI6MiwiaWF0IjoxNjM3NDM1NDA4fQ.op17kX6KrJk8iUUVUW5YqSKsE05OKDGbGQ92Ct71E9c',
          },
          body: body);

  log("Post addExercise: " + "$mainUrl/class/AddClass");
  log("Post body addExercise: " + body);
  //log("Response Json addExercise: ${json.decode(response.body)}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
