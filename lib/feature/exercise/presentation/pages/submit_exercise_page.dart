import 'dart:collection';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/data_source/add_answer.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_description.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/list_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/pick_multi_file.dart';

class SubmitExercisePage extends StatefulWidget {
  final String? titleExercise;
  final int? idExercise;
  static const String routeName = "/SubmitExercisePage";

  const SubmitExercisePage({Key? key, this.titleExercise, this.idExercise})
      : super(key: key);

  @override
  _SubmitExercisePageState createState() => _SubmitExercisePageState();
}

class _SubmitExercisePageState extends State<SubmitExercisePage> {
  TextEditingController? _controllerDescription;

  String? description;

  FilePickerResult? result;
  List<PlatformFile>? listFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _controllerDescription = TextEditingController();
    });
    listFile = [];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(context: context, title: widget.titleExercise),
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
                inputDescription(
                    title: "Online text",
                    context: context,
                    function: (value) {
                      description = value;
                    },
                    textEditingController: _controllerDescription),
                SizedBox(
                  height: size.width / 15,
                ),

                /// pick file từ máy
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

                        /// duyệt mảng chỉ show 1-1
                        listFile = LinkedHashSet<PlatformFile>.from(listFile!)
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
                /// nút xac nhận
                accpect(
                    content: "Accpect",
                    context: context,
                    function: () {
                      /// gọi api thêm bài tập
                      addAnswer(
                          idExercise: widget.idExercise,
                          descriptionAnswer: description,
                          success: () => showSuccess(),
                          failure: () => showCancel(),
                          listFile: listFile);
                      // }
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
        description: "Failed submission");
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
        description: "Successful submission");
  }
}
