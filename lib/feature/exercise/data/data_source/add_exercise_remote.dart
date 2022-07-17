import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

http.Client? client = http.Client();

Future<bool> addExercise(
    {String? titleExercise,
    String? idCourse,
    String? descriptionExercise,
    DateTime? allowSubmission,
    int? isTextPoint,
    DateTime? submissionDeadline,
    List<PlatformFile>? listFile,
    Function? success,
    Function? failure}) async {
  var uri = Uri.parse('$mainUrl/exercise/AddExercise');
  var request = http.MultipartRequest('POST', uri);
  request.headers["Accept"] = "application/json";
  request.headers["auth-token"] = "${appUser?.token}";
  request.headers["Content-Type"] = "multipart/form-data";

  request.fields["titleExercise"] = "$titleExercise";
  if (descriptionExercise != null) {
    request.fields["descriptionExercise"] = "$descriptionExercise";
  }
  if (allowSubmission != null) {
    request.fields["allowSubmission"] = "$allowSubmission";
  }
  if (submissionDeadline != null) {
    request.fields["submissionDeadline"] = "$submissionDeadline";
  }
  request.fields["isTextPoint"] = "$isTextPoint";

  request.fields["files"] = "files";
  request.fields['idCourse'] = '$idCourse';
  for (var item in listFile!) {
    var file = await http.MultipartFile.fromPath("files", item.path!);
    request.files.add(file);
  }

  var response = await request.send();
  var a = await response.stream.toBytes();
  var b = String.fromCharCodes(a);
  print("${b}");
  print("${response.request}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
