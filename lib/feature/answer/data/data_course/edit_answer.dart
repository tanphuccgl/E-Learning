import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:thuc_tap_tot_nghiep/core/config/constants.dart';
import 'package:thuc_tap_tot_nghiep/core/error/exceptions.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/models/get_info_answer_res.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

http.Client? client = http.Client();

Future<bool> editAnswer(
    {int? idAnswer,
      int? idExercise ,

      String? descriptionAnswer,
      List<FileUpload>? fileKeep,
      List<PlatformFile>? listFile,
      Function? success,
      Function? failure}) async {

  ///chua chinh link api
  var uri = Uri.parse('$mainUrl/answer/EditAnswer/$idAnswer');
  var request = http.MultipartRequest('PUT', uri);

  request.headers["Accept"] = "application/json";
  request.headers["auth-token"] = "${appUser?.token}";
  request.headers["Content-Type"] = "multipart/form-data";

  request.fields["idAnswer"] = "$idAnswer";



  if (descriptionAnswer != null) {
    request.fields["descriptionAnswer"] = "$descriptionAnswer";
  }
  /// warning
  request.fields["fileKeep"] = "$fileKeep";

  request.fields["files"] = "files";
  request.fields['idExercise'] = '$idExercise';
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
  print("edit answer ${b}");
  print("edit answer ${response.request}");

  if (response.statusCode == 200) {
    success!();
    return true;
  } else {
    failure!();
    throw ServerException();
  }
}
