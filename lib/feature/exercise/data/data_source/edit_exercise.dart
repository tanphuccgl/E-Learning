import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
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
  print(idCourse);
  ///chua chinh link api
  var uri = Uri.parse('$mainUrl/lecture/OpenLecture?idCourse=$idCourse');
  var request = http.MultipartRequest('PUT', uri);

  request.headers["Accept"] = "application/json";
  request.headers["auth-token"] = "${appUser?.token}";
  request.headers["Content-Type"] = "multipart/form-data";

  request.fields["titleExercise"] = "$titleExercise";
  request.fields["idExercise"] = "$idExercise";

  if (allowSubmission != null) {
    request.fields["allowSubmission"] = "$allowSubmission";
  }
  if (submissionDeadline != null) {
    request.fields["submissionDeadline"] = "$submissionDeadline";
  }

  if (descriptionExercise != null) {
    request.fields["descriptionAnswer"] = "$descriptionExercise";
  }
  /// warning
  request.fields["fileKeep"] = "$fileKeep";

  request.fields["files"] = "files";
  request.fields['idCourse'] = '$idCourse';
  for (var item in listFile!) {
    var file = await http.MultipartFile.fromPath("files", item.path!);
    request.files.add(file);
  }
  // for (var item in listFile!) {
  //   var file = await http.MultipartFile.fromPath("fileKeep", item.path!);
  //   request.files.add(file);
  // }

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
