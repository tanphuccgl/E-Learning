import 'dart:convert';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/models/get_info_lecture_res.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

http.Client? client = http.Client();

Future<bool> editExercise(
    {int? idExercise,
    String? idCourse,
    String? titleExercise,
    String? descriptionExercise,
    String? allowSubmission,
    String? submissionDeadline,
    List<Files>? fileKeep,
    List<PlatformFile>? listFile,
    Function? success,
    Function? failure}) async {
  var uri = Uri.parse('$mainUrl/exercise/EditExercise');
  var request = http.MultipartRequest('PUT', uri);

  for (int i = 0; i < fileKeep!.length; i++) {
    request.fields["fileKeep[$i]"] = "${fileKeep[i].filename!}";
    print("hihi ${request.fields["fileKeep[$i]"]}");
  }

  request.headers["Accept"] = "application/json";
  request.headers["auth-token"] = "${appUser?.token}";
  request.headers["Content-Type"] = "multipart/form-data";

  // request.headers["Content-Type"] = "application/json";

  request.fields["titleExercise"] = "$titleExercise";
  request.fields["idExercise"] = "$idExercise";

  if (allowSubmission != null) {
    request.fields["allowSubmission"] = "$allowSubmission";
  } else {
    request.fields["allowSubmission"] =
        "${DateFormat("yyyy/MM/dd hh:mm").format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(DateTime.now().toString()))}";
  }

  if (submissionDeadline != null) {
    request.fields["submissionDeadline"] = "$submissionDeadline";
  } else {
    request.fields["submissionDeadline"] = "null";
  }

  if (descriptionExercise != null) {
    request.fields["descriptionExercise"] = "$descriptionExercise";
  }

  request.fields['idCourse'] = '$idCourse';
  request.fields["files"] = "files";

  for (var item in listFile!) {
    var file = await http.MultipartFile.fromPath("files", item.path!);
    request.files.add(file);
  }

  var response = await request.send();
  var a = await response.stream.toBytes();
  var b = String.fromCharCodes(a);
  print("editExercise ${b}");
  print("editExercise request ${response.request}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
