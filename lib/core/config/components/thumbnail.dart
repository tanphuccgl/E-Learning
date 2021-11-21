import 'package:thuc_tap_tot_nghiep/core/config/components/type_file.dart';

String thumbnail({String? image}) {
  if (TypeFile.fileStorage.contains(image)) {
    return "files-and-folders.png";
  } else if (TypeFile.fileVideo.contains(image)) {
    return "video.png";
  } else if (TypeFile.fileSound.contains(image)) {
    return "file.png";
  } else if (TypeFile.fileSpreadsheet.contains(image)) {
    return "excel.png";
  } else if (TypeFile.fileDocument.contains(image)) {
    return "documents.png";
  } else if (image == TypeFile.fileText) {
    return "txt.png";
  } else {
    return "file(1).png";
  }
}
