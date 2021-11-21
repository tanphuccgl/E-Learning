import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

http.Client? client = http.Client();

Future<bool> addAnswer(
    {String? descriptionAnswer ,
      int? idExercise ,

      List<PlatformFile>? listFile,
      Function? success,
      Function? failure}) async {
  print(idExercise);
  print(descriptionAnswer);
  var uri = Uri.parse('$mainUrl/answer/AddAnswer');
  var request = http.MultipartRequest('POST', uri);

  request.headers["Accept"] = "application/json";
  request.headers["auth-token"] = "${appUser?.token}";
  request.headers["Content-Type"] = "multipart/form-data";


  if (descriptionAnswer != null) {
    request.fields["descriptionAnswer"] = "$descriptionAnswer";
  }

  request.fields["files"] = "files";
  request.fields['idExercise'] = '$idExercise';
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
