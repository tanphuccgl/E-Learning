import 'dart:collection';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/detail_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_description.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_title.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/list_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/pick_multi_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/data_source/add_lecture.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/pages/lecture_page.dart';

class CreateLecturePage extends StatefulWidget {
  final String? idCourse;
  final String? nameCourse;
  static const String routeName = "/CreateLecturePage";

  const CreateLecturePage({Key? key, this.idCourse, this.nameCourse})
      : super(key: key);

  @override
  _CreateLecturePageState createState() => _CreateLecturePageState();
}

class _CreateLecturePageState extends State<CreateLecturePage> {
  TextEditingController? _controllerText;
  TextEditingController? _controllerDescription;
  String? nameLecture;
  String? description;

  bool? isSwitchedDue;
  FilePickerResult? result;
  List<PlatformFile>? listFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _controllerText = TextEditingController();
      _controllerDescription = TextEditingController();
    });
    listFile = [];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context: context, title: "Create New Lecture"),
      body: SingleChildScrollView(
        child: Container(
          height: size.width / 0.37,
          width: size.width,
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width / 25,
                right: size.width / 25,
                top: size.width / 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Nh???p t??n b??i t???p
                inputName(
                    title: "Name Lecture",
                    function: (value) {
                      nameLecture = value;
                    },
                    context: context,
                    textEditingController: _controllerText,
                    hintText: "Input name"),
                SizedBox(
                  height: size.width / 20,
                ),

                /// Nh???p m?? t???
                inputDescription(
                    title: "Description",
                    context: context,
                    textEditingController: _controllerDescription,
                    function: (value) {
                      description = value;
                    }),
                SizedBox(
                  height: size.width / 20,
                ),

                /// pick file t??? m??y
                chooseFile(
                    title: "Additional files",
                    function: () async {
                      result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);
                      List<PlatformFile>? listFile1 = [];

                      if (result != null) {
                        setState(() {
                          listFile1 = result!.files;
                        });

                        listFile!.addAll(listFile1!);

                        /// duy???t m???ng ch??? show 1-1
                        listFile = LinkedHashSet<PlatformFile>.from(listFile!)
                            .toList();
                      } else {
                        // User canceled the picker
                      }
                    },
                    context: context),

                /// show nh???ng file ???????c ch???n
                ListFiles(
                  list: listFile,
                ),

                /// n??t xac nh???n
                accept(
                    context: context,
                    content: "Accept",
                    function: () {
                      ///check nh???p t??n b??i t???p
                      if (nameLecture?.trim().length == 0 ||
                          nameLecture == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Input name Course"),
                        ));
                      } else {
                        /// g???i api th??m b??i gi???ng
                        addLecture(
                            idCourse: widget.idCourse,
                            descriptionLecture: description,
                            nameLecture: nameLecture,
                            success: () => showSuccess(),
                            failure: () => showCancel(),
                            listFile: listFile);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showCancel() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
        },
        title: "ERROR",
        description: "Failed lecture creation");
  }

  void showSuccess() {
    return showPopup(
        context: context,
        function: () {
          print(widget.idCourse);
          print(widget.nameCourse);

          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailCoursePage(
                        idCourse: widget.idCourse,
                        nameCourse: widget.nameCourse,
                        choosingPos: 1,
                        widgetId: 1,
                      )));
        },
        title: "SUCCESS",
        description: "Create successful lecture");
  }
}
