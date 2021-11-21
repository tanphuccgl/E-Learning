import 'package:intl/intl.dart';

String parseStringToTime({String? textTime}) {
  /// 2021-11-18T17:13:00.475Z
  /// ///2021/11/21 13:59
  String showTime;
  DateTime dateTime;
  if (textTime != null) {
    dateTime = DateFormat('yyyy/MM/dd hh:mm').parse(textTime);
    showTime = DateFormat('d/MM/yyyy, hh:mm a').format(dateTime);
  } else {
    showTime = "";
  }

  return showTime;
}
