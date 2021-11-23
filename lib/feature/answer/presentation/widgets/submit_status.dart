import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/thumbnail.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/type_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/models/get_info_answer_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class BodyInfoAnswer extends StatefulWidget {
  final int? idAccount;
  final int? idAnswer;
  final String? allowSubmission;
  final String? submissionDeadline;

  const BodyInfoAnswer(
      {Key? key,
      this.idAnswer,
      this.idAccount,
      this.allowSubmission,
      this.submissionDeadline})
      : super(key: key);

  @override
  _BodyInfoAnswerState createState() => _BodyInfoAnswerState();
}

class _BodyInfoAnswerState extends State<BodyInfoAnswer> {
  @override
  Widget build(BuildContext context) {
    print(widget.idAccount);
    print(widget.idAnswer);
    return BlocBuilder<GetInformationAnswerBloc, GetInformationAnswerState>(
        builder: (context, state) {
      if (state is Empty) {
        getInfo();
      } else if (state is Loaded) {
        return _submitStatus(
            title: "Submission status",
            context: context,
            data: state.swagger?.data,
            submissionDeadline: widget.submissionDeadline);
      } else if (state is Loading) {
        return SpinkitLoading();
      } else if (state is Error) {
        return Center(
          child: Text("Lỗi hệ thống"),
        );
      }
      return Container();
    });
  }

  void getInfo() {
    BlocProvider.of<GetInformationAnswerBloc>(context).add(
        GetInformationAnswerEventE(
            idAnswer: widget.idAnswer, idAccount: appUser?.iId));
  }

  Widget _uploadedFile({List<FileUpload>? list, String? title}) {
    Size size = MediaQuery.of(context).size;
    return _listFile(list: list);
  }

  Widget _listFile({List<FileUpload>? list}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,

      ///  widget.list!.length > 4 ? size.width / 1.4 : widget.list!.length * size.width / 6,
      height:
          list!.length > 4 ? size.width / 1.4 : list.length * size.width / 6,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              height: size.width / 7,
              width: size.width / 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TypeFile.fileImage.contains(
                              list[index].originalname?.split(".").last)
                          ? Container(
                              height: size.width / 10,
                              width: size.width / 10,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${list[index].pathname}"),
                                      fit: BoxFit.cover)),
                            )
                          : Container(
                              height: size.width / 10,
                              width: size.width / 10,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/${thumbnail(image: list[index].originalname?.split(".").last)}"),
                                      fit: BoxFit.cover)),
                            ),
                      SizedBox(
                        width: size.width / 15,
                      ),
                      _detailFile(file: list[index]),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_circle_down),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: list.length),
    );
  }

  Widget _detailFile({FileUpload? file}) {
    Size size = MediaQuery.of(context).size;
    final kb = file!.size! / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? "${mb.toStringAsFixed(2)} MB" : "${kb.toStringAsFixed(2)} KB";
    return Container(
      height: size.width / 7,
      width: size.width / 1.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${file.originalname}",
            style: TextStyle(color: Colors.black, fontSize: size.width / 20),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: size.width / 5,
                child: Text(
                  "$fileSize",
                  style:
                      TextStyle(color: Colors.black, fontSize: size.width / 25),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                width: size.width / 10,
              ),
            ],
          )
          // Text("${list[index].extension}"),
          // Text("$fileSize"),
        ],
      ),
    );
  }

  ///Submission status
  Widget _submitStatus(
      {String? title,
      BuildContext? context,
      GetInformationAnswerData? data,
      String? submissionDeadline}) {
    Size size = MediaQuery.of(context!).size;

    return Container(

      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: size.width / 20),
          ),
          Container(
            height: size.width / 1.2,
            width: size.width,
            child: ListView(physics: const NeverScrollableScrollPhysics(),
              children: [
                DataTable(
                  columns: [
                    DataColumn(
                        label: Text('Submission\nstatus',
                            style: TextStyle(
                                fontSize: size.width / 25,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Container(
                      width: size.width / 1.8,
                      height: size.width,
                      color: data?.createDate == null
                          ? Colors.white
                          : Colors.green.withOpacity(0.8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            data?.createDate == null
                                ? 'No attempt'
                                : "Submitted for grading",
                            style: TextStyle(
                                fontSize: size.width / 28,
                                fontWeight: FontWeight.normal)),
                      ),
                    )),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('Grading status',
                          style: TextStyle(
                              fontSize: size.width / 25,
                              fontWeight: FontWeight.bold))),
                      DataCell(Container(
                          width: size.width / 1.8,
                          height: size.width,
                          color: data?.studyPoint == null
                              ? Colors.red.withOpacity(0.8)
                              : Colors.green.withOpacity(0.8),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(data?.studyPoint == null
                                  ? "Not grade"
                                  : "Grade: ${data?.studyPoint}")))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Time remaining',
                          style: TextStyle(
                              fontSize: size.width / 25,
                              fontWeight: FontWeight.bold))),
                      DataCell(Text(submissionDeadline == null
                          ? ""
                          : formatTime(timeDue: submissionDeadline))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Last modified',
                          style: TextStyle(
                              fontSize: size.width / 25,
                              fontWeight: FontWeight.bold))),
                      DataCell(Text(data?.updateDate == null
                          ? ""
                          : '${data?.updateDate}')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Comment',
                          style: TextStyle(
                              fontSize: size.width / 25,
                              fontWeight: FontWeight.bold))),
                      DataCell(Text("${data?.feedbackFromTeacher}")),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Attachments',
                          style: TextStyle(
                              fontSize: size.width / 25,
                              fontWeight: FontWeight.bold))),
                      DataCell(
                        _uploadedFile(list: data?.feedbackFromTeacherByImage),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
///Submission status
Widget submitStatus(
    {String? title,
      BuildContext? context,
      GetInformationAnswerData? data,
      String? submissionDeadline}) {
  Size size = MediaQuery.of(context!).size;

  return Container(
    height: size.width / 1.1,
    width: size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: size.width / 20),
        ),
        Container(
          height: size.width / 1.2,
          width: size.width,
          child: ListView(
            children: [
              DataTable(
                columns: [
                  DataColumn(
                      label: Text('Submission\nstatus',
                          style: TextStyle(
                              fontSize: size.width / 25,
                              fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Container(
                        width: size.width / 1.8,
                        height: size.width,
                        color: data?.createDate == null
                            ? Colors.white
                            : Colors.green.withOpacity(0.8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              data?.createDate == null
                                  ? 'No attempt'
                                  : "Submitted for grading",
                              style: TextStyle(
                                  fontSize: size.width / 28,
                                  fontWeight: FontWeight.normal)),
                        ),
                      )),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Grading status',
                        style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.bold))),
                    DataCell(Container(
                        width: size.width / 1.8,
                        height: size.width,
                        color: data?.studyPoint == null
                            ? Colors.red.withOpacity(0.8)
                            : Colors.green.withOpacity(0.8),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(data?.studyPoint == null
                                ? "Not grade"
                                : "Grade: ${data?.studyPoint}")))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Time remaining',
                        style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.bold))),
                    DataCell(Text(submissionDeadline == null
                        ? ""
                        : formatTime(timeDue: submissionDeadline))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Last modified',
                        style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.bold))),
                    DataCell(Text(data?.updateDate == null
                        ? ""
                        : '${data?.updateDate}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Comment',
                        style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.bold))),
                    DataCell(Text(data?.feedbackFromTeacher==null?"":"${data?.feedbackFromTeacher}")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Attachments',
                        style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.bold))),
                    DataCell(
                     Text(""),
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

String formatTime({String? timeDue}) {
  print("time now ${DateTime.now()}");
  print("time due ${stringToDateTime(string: timeDue)}");

  ///3 -78 -4737
  /// ngay = 4737/60/24  = 3,289583333333333
  ///   gio= 4737/60 - ngay*24  =6.5
  ///   phut = 4737 -gio*60*24 -6 *60
  ///

  int day = daysBetween(DateTime.now(), stringToDateTime(string: timeDue)) ~/
      (60 * 24);

  int hour =
      (daysBetween(DateTime.now(), stringToDateTime(string: timeDue)) ~/ (60)) -
          day * 24;

  int minute = daysBetween(DateTime.now(), stringToDateTime(string: timeDue)) -
      hour * 60 -
      day * 24 * 60;

  // if (day == 0) {
  //   return "$hour hour $minute minute";
  // } else if (day == 0 && hour == 0) {
  //   return "$minute minute";
  // } else if (day == 0 && hour == 0 && minute == 0) {}
print( "${day} day ${hour} hour ${minute} minute");
  return "${day} day ${hour} hour ${minute} minute";
}

DateTime stringToDateTime({String? string}) {
  return DateFormat("yyyy/MM/dd hh:mm").parse(string!);
}

int daysBetween(
  DateTime from,
  DateTime to,
) {
  from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
  to = DateTime(to.year, to.month, to.day, to.hour, to.minute);
  return (to.difference(from).inMinutes).round();
}
