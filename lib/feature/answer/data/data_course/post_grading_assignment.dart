import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

http.Client? client = http.Client();

Future<bool> postGradingAssignment(
    {String? feedbackFromTeacher,
    int? idAnswer,
    var studyPoint,
    List<PlatformFile>? listFile,
    Function? success,
    Function? failure}) async {

  print(studyPoint);

  var uri = Uri.parse(
      '$mainUrl/answer/GradingAssignment');
  var request = http.MultipartRequest('POST', uri);

  request.headers["Accept"] = "application/json";
  request.headers["auth-token"] = "${appUser?.token}";
  request.headers["Content-Type"] = "multipart/form-data";

  // if (descriptionAnswer != null) {
  //   request.fields["descriptionAnswer"] = "$descriptionAnswer";
  // }
  request.fields["feedbackFromTeacher"] = "$feedbackFromTeacher";
  request.fields["studyPoint"] = "$studyPoint ";
  request.fields["files"] = "files";
  request.fields['idAnswer'] = '$idAnswer';
  for (var item in listFile!) {
    var file = await http.MultipartFile.fromPath("files", item.path!);
    request.files.add(file);
  }
  print("Fsdafds");

  var response = await request.send();
  print("Fsdafds");
  var a = await response.stream.toBytes();
  var b = String.fromCharCodes(a);
  print("${response.request}");
  print("${b}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
