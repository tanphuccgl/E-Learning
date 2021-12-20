import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/size.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/pages/grading_assignment_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_grade_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_grade_exercise/get_grade_exercise_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_grade_exercise/get_grade_exercise_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_grade_exercise/get_grade_exercise_state.dart';

class BodyGradeExe extends StatefulWidget {
  final String? idCourse;
  final int? idExercise;
  final int? isTextPoint;

  const BodyGradeExe(
      {Key? key, this.idExercise, this.idCourse, this.isTextPoint})
      : super(key: key);

  @override
  _BodyGradeExeState createState() => _BodyGradeExeState();
}

class _BodyGradeExeState extends State<BodyGradeExe> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetGradeExerciseBloc, GetGradeExerciseState>(
        builder: (context, state) {
      if (state is Empty) {
        getGradeExe();
      } else if (state is Loaded) {
        return state.data!.isNotEmpty
            ? _list(list: state.data)
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

  Widget _list({List<GetGradeExerciseData>? list}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 1.2,
      width: size.width,
      child: Padding(
        padding: EdgeInsets.only(
            left: size.width / 25,
            right: size.width / 25,
            top: size.width / 20),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _title(name: "No", width: size.width / 11),
                  _title(name: "Name", width: size.width / 3.5),
                  _title(name: "Point", width: size.width / 9),
                  _title(name: "Status", width: size.width / 5),
                ],
              ),
            ),
            Container(
              height: size.height / 1.3,
              width: size.width,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    height: size.width / 5,
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _data(text: "${index + 1}", width: size.width / 11),
                        _data(
                            text: "${list![index].fullName}",
                            width: size.width / 3.5),
                        Container(
                          width: size.width / 9,
                          child: Center(
                            child: point(
                                createDate: list[index].createDate,
                                data: list[index],
                                isTextPoint: list[index].isTextPoint,
                                point: list[index].studyPoint.toString()),
                          ),
                        ),
                        _data(
                            text: list[index].createDate == null
                                ? "No attempt"
                                : ("Submitted"),
                            width: size.width / 5),
                      ],
                    ),
                  );
                },
                itemCount: list!.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget point(
      {var point,
      String? createDate,
      GetGradeExerciseData? data,
      int? isTextPoint}) {
    Size size = MediaQuery.of(context).size;

    if (point == null && createDate == null) {
      return Text(
        "",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: size.width / 30),
      );
    } else if (createDate != null && point == "null") {
      return TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GradingAssignmentPage(
                          isTextPoint: widget.isTextPoint,
                          idAnswer: data?.idAnswer,
                          idAccount: data?.idAccount,
                          data: data,
                          nameStudent: data?.fullName,
                          createDate: data?.createDate,
                        )));
          },
          child: Text(
            "Mark",
            style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.normal,
                fontSize: size.width / 33),
          ));
    } else if (point != "null") {
      return TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GradingAssignmentPage(
                          isTextPoint: widget.isTextPoint,
                          idAnswer: data?.idAnswer,
                          idAccount: data?.idAccount,
                          data: data,
                          nameStudent: data?.fullName,
                          createDate: data?.createDate,
                        )));
          },
          child: isTextPoint == 0
              ? Text(
                  point!,
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.normal,
                      fontSize: size.width / 30),
                )
              : Text(
                  point == "0" ? "Không đạt" : "Đạt",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.normal,
                      fontSize: size.width / 30),
                ));
    } else if (point == "null") {
      return Text(
        "",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: size.width / 30),
      );
    } else {
      return Text(
        "Error",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: size.width / 30),
      );
    }
  }

  Widget _data({String? text, double? width}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: width,
      child: Center(
        child: Text(
          text!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: size.width / 30),
        ),
      ),
    );
  }

  Widget _title({String? name, double? width}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: width,
      child: Center(
        child: Text(
          name!,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size.width / 25),
        ),
      ),
    );
  }

  void getGradeExe() {
    BlocProvider.of<GetGradeExerciseBloc>(context).add(GetGradeExerciseEventE(
        idCourse: widget.idCourse, idExercise: widget.idExercise));
  }
}
