import 'dart:collection';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/thumbnail.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/type_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/data_course/post_grading_assignment.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/models/get_info_answer_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/list_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/pick_multi_file.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class BodyGradingAssignment extends StatefulWidget {
  final int? idAccount;
  final int? idAnswer;
  final String? nameStudent;
  final String? createDate;

  const BodyGradingAssignment(
      {Key? key,
      this.idAnswer,
      this.idAccount,
      this.nameStudent,
      this.createDate})
      : super(key: key);

  @override
  _BodyGradingAssignmentState createState() => _BodyGradingAssignmentState();
}

class _BodyGradingAssignmentState extends State<BodyGradingAssignment> {
  double? point;
  TextEditingController? pointController;
  String? cmt;
  TextEditingController? cmtController;
  List<bool> _isSelected = [true, false];
  List<PlatformFile>? listFile;
  FilePickerResult? result;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cmt = "";
    point = null;
    pointController = TextEditingController();
    cmtController = TextEditingController();
    listFile = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetInformationAnswerBloc, GetInformationAnswerState>(
        builder: (context, state) {
      if (state is Empty) {
        getInfo();
      } else if (state is Loaded) {
        Size size = MediaQuery.of(context).size;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: size.width,
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width / 25,
                    right: size.width / 25,
                    top: size.width / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title(
                        name: "Name student: ${widget.nameStudent}",
                        createDate: widget.createDate),
                    SizedBox(
                      height: size.width / 20,
                    ),
                    framesGrade(point: point),
                    chooseFile(
                        title: "Attached files",
                        function: () async {
                          result = await FilePicker.platform
                              .pickFiles(allowMultiple: true);
                          List<PlatformFile>? listFile1 = [];

                          if (result != null) {
                            setState(() {
                              listFile1 = result!.files;
                            });

                            listFile!.addAll(listFile1!);

                            /// duyệt mảng chỉ show 1-1
                            listFile =
                                LinkedHashSet<PlatformFile>.from(listFile!)
                                    .toList();
                          } else {
                            // User canceled the picker
                          }
                        },
                        context: context),

                    /// show những file được chọn
                    ListFiles(
                      list: listFile,
                    ),
                    Padding(
                      padding: EdgeInsets.all(size.width / 25),
                      child: Center(
                          child: Text(
                        "Submitted assignments",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width / 20),
                      )),
                    ),

                    /// cmt
                    _content(
                        content: state.swagger?.data?.descriptionAnswer == null
                            ? ""
                            : state.swagger?.data?.descriptionAnswer),

                    ///pick file

                    SizedBox(
                      height: size.width / 20,
                    ),
                    _uploadedFile(
                        list: state.swagger?.data?.fileUpload,
                        title:
                            "Uploaded File (${state.swagger?.data?.fileUpload?.length})"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        changePage(
                            icon: Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                            context: context,
                            function: () {}),
                        accept(
                            content: "Accept",
                            context: context,
                            function: () {
                              ///check nhập tên bài tập
                              if (point?.toString().trim().length == 0 ||
                                  point == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Input Score"),
                                ));
                              } else {
                                postGradingAssignment(
                                    idAnswer: widget.idAnswer,
                                    studyPoint: point,
                                    feedbackFromTeacher: cmt,
                                    success: () => showSuccess(),
                                    failure: () => showCancel(),
                                    listFile: listFile);
                              }
                            }),
                        changePage(
                            icon: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            context: context,
                            function: () {}),
                      ],
                    ),

                  ],
                ),
              )),
        );
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

  Widget _uploadedFile({List<FileUpload>? list, String? title}) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width / 20,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  height: size.width / 10,
                  child: ToggleButtons(
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width / 30)),
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Icon(Icons.arrow_drop_up_rounded),
                      Icon(
                        Icons.arrow_drop_down_outlined,
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0;
                            buttonIndex < _isSelected.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            _isSelected[buttonIndex] = true;
                          } else {
                            _isSelected[buttonIndex] = false;
                          }
                        }
                      });
                    },
                    isSelected: _isSelected,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.width / 20,
            ),
            _isSelected[0] == true
                ? _listFile(list: list)
                : _enlargeFile(list: list),
          ],
        ));
  }

  Widget _enlargeFile({List<FileUpload>? list}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,

      ///  widget.list!.length > 4 ? size.width / 1.4 : widget.list!.length * size.width / 6,
      height: size.width / 0.65 * list!.length,
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: size.width / 3),
              child: Container(
                width: size.width,
                child: TypeFile.fileImage
                        .contains(list[index].originalname?.split(".").last)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: size.width,
                            width: size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        NetworkImage("${list[index].pathname}"),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            height: size.width / 20,
                          ),
                          Text(
                            "${list[index].originalname}",
                            style: TextStyle(
                                color: Colors.black, fontSize: size.width / 25),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
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
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: list.length),
    );
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
              Text(
                "${file.originalname?.split(".").last}",
                style:
                    TextStyle(color: Colors.black, fontSize: size.width / 25),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          )
          // Text("${list[index].extension}"),
          // Text("$fileSize"),
        ],
      ),
    );
  }

  Widget _content({String? content}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width / 2,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(size.width / 30),
          ),
          color: Colors.grey.shade300.withOpacity(0.3),
          border: Border.all(
              color: Colors.cyan.withOpacity(0.3), width: size.width / 100)),
      child: Padding(
        padding: EdgeInsets.all(size.width / 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Description",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              height: size.width / 3.2,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Text(
                    content!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width / 25,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //String? feedback, TextEditingController? textEditingController
  Widget framesGrade({double? point}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.width / 3.5,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDialogPoint();
            },
            child: Container(
              width: size.width / 3.4,
              height: size.width / 3.5,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        child: Text("Point"),
                        alignment: Alignment.topCenter,
                      ),
                      SizedBox(
                        height: size.width / 35,
                      ),
                      Center(
                        child: Text(
                          point == null ? "" : "$point",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width / 10),
                        ),
                      )
                    ],
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialogCmt();
            },
            child: Container(
              width: (2 * size.width) / 3.5,
              height: size.width / 3.5,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      child: Text("Teacher's comment"),
                      alignment: Alignment.topCenter,
                    ),
                    SizedBox(
                      height: size.width / 35,
                    ),
                    Container(
                      height: size.width / 7,
                      child: Text(
                        "$cmt",
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.normal,
                            fontSize: size.width / 35),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDialogCmt() {
    showDialog(
      context: context,
      builder: (_) {
        Size size = MediaQuery.of(context).size;

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Container(
              height: size.width / 20,
              width: size.width / 1,
              child: Text('Comment')),
          content: Container(
            height: size.width / 2,
            width: size.width,
            child: TextField(
              controller: cmtController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(700),
              ],
              maxLines: 20,
              decoration: InputDecoration(
                hintText: 'Input Comment',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                fillColor: Colors.white,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Send them to your email maybe?

                cmt = cmtController!.text;
                Navigator.pop(context);
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

  Widget _title({String? name, String? createDate}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width / 20,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name!,
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
          ),
          Text(
            createDate!,
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      ),
    );
  }

  void getInfo() {
    BlocProvider.of<GetInformationAnswerBloc>(context).add(
        GetInformationAnswerEventE(
            idAnswer: widget.idAnswer, idAccount: widget.idAccount));
  }

  void showDialogPoint() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text('Score'),
          content: TextFormField(
            controller: pointController,
            decoration: InputDecoration(hintText: 'Input Score'),
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: false),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Send them to your email maybe?

                point = double.tryParse(pointController!.text);
                if (point == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Invalid score"),
                  ));
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void showCancel() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
        },
        title: "ERROR",
        description: "Fail grading");
  }

  void showSuccess() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
          Navigator.pop(context);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => DetailCoursePage(
          //           idCourse: widget.idCourse,
          //           nameCourse: widget.nameCourse,
          //           widgetId: 2,
          //           choosingPos: 2,
          //         )));
        },
        title: "SUCCESS",
        description: "Successful grading");
  }
}
