import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/parse_time.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/type_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/pages/info_answer_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/widgets/grading_summary.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/widgets/submit_status.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_info_exercise/get_info_exercise_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_info_exercise/get_info_exercise_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_info_exercise/get_info_exercise_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/create_exercise_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/execise_page.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/thumbnail.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/grade_exercise_teacher_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/submit_exercise_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class BodyDetailExercise extends StatefulWidget {
  final int? idExercise;

  const BodyDetailExercise({Key? key, this.idExercise}) : super(key: key);

  @override
  _BodyDetailExerciseState createState() => _BodyDetailExerciseState();
}

class _BodyDetailExerciseState extends State<BodyDetailExercise> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetInfoExerciseBloc, GetInfoExerciseState>(
        builder: (context, state) {
      if (state is Empty) {
        getDetailExe();
      } else if (state is Loaded) {
        Size size = MediaQuery.of(context).size;

        return state.data != null
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: _appBar(title: state.data?.titleExercise),
                body: SingleChildScrollView(
                  child: Container(
                    width: size.width,

                    child: Padding(
                      padding: EdgeInsets.only(
                          left: size.width / 25,
                          right: size.width / 25,
                          top: size.width / 20),
                      child: Column(
                        children: [
                          ///khung giờ nộp bài
                          _header(
                              allowSubmission: state.data?.allowSubmission,
                              submissionDeadline:
                                  state.data?.submissionDeadline),
                          /// mô tả
                          _content(
                              content: state.data?.descriptionExercise == null
                                  ? ""
                                  : state.data?.descriptionExercise),
                          SizedBox(
                            height: size.width / 15,
                          ),

                          ///pick file
                          _uploadedFile(
                              list: state.data?.files, title: "Uploaded File (${state.data?.files?.length})"),
                          SizedBox(
                            height: size.width / 15,
                          ),
                          ///
                          appUser?.role == "teacher"
                              ? gradingSummary(
                                  context: context, title: "Grading summary")
                              : InfoAnswerPage(
                                  idAccount: appUser?.iId,
                                  idAnswer: state.data?.idAnswer,
                                  submissionDeadline:
                                      state.data?.submissionDeadline,
                                  allowSubmission: state.data?.allowSubmission),
                          appUser?.role == "teacher"
                              ? accpect(
                                  context: context,
                                  function: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GradeExerciseTeacherPage(
                                                    idExercise:
                                                        widget.idExercise,isTextPoint:state.data?.isTextPoint,
                                                    idCourse:
                                                        state.data?.idCourse)));
                                  },
                                  content: "View all")
                              : accpect(
                                  context: context,
                                  function: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubmitExercisePage(
                                                    idExercise:
                                                        widget.idExercise,
                                                    titleExercise: state
                                                        .data?.titleExercise)));
                                  },
                                  content: "Submit"),
                          SizedBox(
                            height: size.width / 15,
                          ),
                        ],
                      ),
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
    });
  }

  void getDetailExe() {
    BlocProvider.of<GetInfoExerciseBloc>(context)
        .add(GetInfoExerciseEventE(idExercise: widget.idExercise));
  }

  Widget _uploadedFile({List<Files>? list, String? title}) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.width / 20,
            ),
            _listFile(list: list),
          ],
        ));
  }

  Widget _listFile({List<Files>? list}) {
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

  Widget _detailFile({Files? file}) {
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

  Widget _content({String? content}) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.width / 15),
      child: Container(
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
      ),
    );
  }

  Widget _header({String? submissionDeadline, String? allowSubmission}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width / 5,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(size.width / 30),
        ),
        color: Colors.cyan.withOpacity(0.3),
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width / 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Allow Submission: ${parseStringToTime(textTime: allowSubmission)}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width / 25,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Submission Deadline: ${parseStringToTime(textTime: submissionDeadline)}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width / 25,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  PreferredSize _appBar({String? title}) {
    Size size = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size.fromHeight(size.width / 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          title!,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size.width / 15),
        ),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}