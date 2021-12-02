import 'dart:collection';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog2.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/data_course/delete_answer.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/data_source/add_answer.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/detail_exercise_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_description.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/list_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/pick_multi_file.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class SubmitExercisePage extends StatefulWidget {
  final String? titleExercise;
  final int? idExercise;
  final String? nameExercise;
  final String? allowSubmission;
  final int? idAnswer;
  final String? submissionDeadline;
  final String? descriptionExercise;
  static const String routeName = "/SubmitExercisePage";

  const SubmitExercisePage(
      {Key? key,
      this.titleExercise,
      this.idAnswer,
      this.idExercise,
      this.submissionDeadline,
      this.nameExercise,
      this.allowSubmission,
      this.descriptionExercise})
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
        body: widget.idAnswer != null
            ? BlocProvider(
                create: (_) => sl<GetInformationAnswerBloc>(),
                child: BlocBuilder<GetInformationAnswerBloc,
                    GetInformationAnswerState>(builder: (context, state) {
                  if (state is Empty) {
                    BlocProvider.of<GetInformationAnswerBloc>(context).add(
                      GetInformationAnswerEventE(
                          idAccount: appUser?.iId, idAnswer: widget.idAnswer),
                    );
                  } else if (state is Loaded) {
                    Size size = MediaQuery.of(context).size;
                    _controllerDescription = TextEditingController(
                        text: state.swagger!.data!.descriptionAnswer);

                    return state.swagger != null
                        ? SingleChildScrollView(
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
                                    inputDescription(
                                        title: "Online text",
                                        context: context,
                                        function: (value) {
                                          description = value;
                                        },
                                        textEditingController:
                                            _controllerDescription),
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
                                            listFile = LinkedHashSet<
                                                        PlatformFile>.from(
                                                    listFile!)
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        accept(
                                            content: "Remove",
                                            color: Colors.red,
                                            context: context,
                                            function: () {
                                              AlertDialog2.yesAbortDialog(
                                                  onPressed: () {
                                                    removeAnswer(
                                                        idAnswer:
                                                            widget.idAnswer,
                                                        failure: () =>
                                                            showCancelDelete(),
                                                        success: () =>
                                                            showSuccessDelete());
                                                  },
                                                  title: "Delete answer",
                                                  body:
                                                      "Are you sure you want to remove the submission data?",
                                                  context: context);
                                            }),
                                        accept(
                                            content: "Edit",
                                            color: Colors.amber,
                                            context: context,
                                            function: () {
                                              /// gọi api thêm bài tập
                                              // addAnswer(
                                              //     idExercise: widget.idExercise,
                                              //     descriptionAnswer: description,
                                              //     success: () => showSuccess(),
                                              //     failure: () => showCancel(),
                                              //     listFile: listFile);
                                              // }
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Center(child: Text("Invail exercise"));
                  } else if (state is Loading) {
                    return SpinkitLoading();
                  } else if (state is Error) {
                    return Center(
                      child: Text("Lỗi hệ thống"),
                    );
                  }
                  return Container();
                }))
            : SingleChildScrollView(
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

                        /// nút xac nhận
                        accept(
                            content: "Accept",
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
              ));
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
          Navigator.pop(context);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailExercisePage(
                        nameExercise: widget.nameExercise,
                        allowSubmission: widget.allowSubmission,
                        submissionDeadline: widget.submissionDeadline,
                        descriptionExercise: widget.descriptionExercise,
                        idExercise: widget.idExercise,
                      )));
        },
        title: "SUCCESS",
        description: "Successful submission");
  }

  void showCancelDelete() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
        },
        title: "ERROR",
        description: "Delete failed");
  }

  void showSuccessDelete() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailExercisePage(
                        nameExercise: widget.nameExercise,
                        allowSubmission: widget.allowSubmission,
                        submissionDeadline: widget.submissionDeadline,
                        descriptionExercise: widget.descriptionExercise,
                        idExercise: widget.idExercise,
                      )));
        },
        title: "SUCCESS",
        description: "Delete successful");
  }
}
