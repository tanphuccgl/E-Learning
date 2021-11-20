import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_course/get_exercise_by_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_course/get_exercise_by_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_course/get_exercise_by_course_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/create_exercise_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/detail_exercise_page.dart';

class ExercisePage extends StatefulWidget {
  final String? idCourse;

  const ExercisePage({Key? key, this.idCourse}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExerciseByCourseBloc, GetExerciseByCourseState>(
        builder: (context, state) {
      if (state is Empty) {
        getCourse();
      } else if (state is Loaded) {
        return state.data!.isNotEmpty
            ? _list(state.data)
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

  Widget _list(List<GetExerciseByCourseData>? list) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.width / 0.75,
      child: Padding(
        padding: EdgeInsets.only(
            left: size.width / 25,
            right: size.width / 25,
            top: size.width / 40),
        child: Column(
          children: [
            _header(datetime: "Mar 22th 2021", countExercise: list?.length,idCourse: widget.idCourse),
            Container(
              width: size.width - size.width / 25,
              height: size.width,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return _item(
                      time:
                          "${parseStringToTime(textTime: list?[index]?.allowSubmission ?? null)} "
                          "- ${parseStringToTime(textTime: list?[index]?.submissionDeadline ?? null)}",
                      titleExercise: list?[index].titleExercise,
                      descriptionExercise: list?[index].descriptionExercise,
                      data: list?[index]);
                },
                itemCount: list?.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header({
    String? datetime,
    int? countExercise,String? idCourse
  }) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width - size.width / 25,
      height: size.width / 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: size.width / 30, bottom: size.width / 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    datetime!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width / 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "You have $countExercise studies",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width / 25,
                        fontWeight: FontWeight.w500),
                  ),
                ]),
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width / 40))),
              child: IconButton(
                icon: Icon(
                  Icons.add,

                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateExercisePage(idCourse: idCourse!,)));
                },
              ))
        ],
      ),
    );
  }

  Widget _item(
      {String? time,
      String? titleExercise,
      String? descriptionExercise,
      GetExerciseByCourseData? data}) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width / 30,
          height: size.width / 3,
          child: Column(
            children: [
              Icon(
                Icons.circle,
                color: Colors.black,
                size: size.width / 30,
              ),
              Container(
                  width: size.width / 100,
                  height: size.width / 3.5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width / 20)),
                  )),
            ],
          ),
        ),
        _card(
            time: time,
            titleExercise: titleExercise,
            descriptionExercise: descriptionExercise,
            data: data),
      ],
    );
  }

  Widget _card(
      {String? time,
      String? titleExercise,
      String? descriptionExercise,
      GetExerciseByCourseData? data}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 1.2,
      height: size.width / 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _timeDeadLine(time: time),
          Padding(
            padding: EdgeInsets.only(bottom: size.width / 20),
            child: Container(
              width: size.width / 1.3,
              height: size.width / 5,
              decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(size.width / 25),
                  )),
              child: Padding(
                padding: EdgeInsets.all(size.width / 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _content(
                        titleExercise: titleExercise,
                        descriptionExercise: descriptionExercise),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailExercisePage(
                                        data: data,
                                      )));
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          size: size.width / 10,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _content({String? titleExercise, String? descriptionExercise}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 1.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// assignment_turned_in_rounded
          Icon(
            Icons.assignment_turned_in_outlined,
            size: size.width / 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                titleExercise!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width / 20),
              ),
              Text(
                descriptionExercise!,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width / 30),
              ),
            ],
          ),
          SizedBox(
            width: size.width / 10,
          ),
        ],
      ),
    );
  }

  Widget _timeDeadLine({String? time}) {
    Size size = MediaQuery.of(context).size;

    return Text(
      time!,
      style: TextStyle(
          fontSize: size.width / 30,
          fontWeight: FontWeight.bold,
          color: Colors.black),
    );
  }

  void getCourse() {
    BlocProvider.of<GetExerciseByCourseBloc>(context)
        .add(GetExerciseByCourseEventE(idCourse: widget.idCourse));
  }
}

String parseStringToTime({String? textTime}) {
  /// 2021-11-18T17:13:00.475Z
  String showTime;
  DateTime dateTime;
  if (textTime != null) {
    dateTime = DateFormat('yyyy-MM-ddThh:mm').parse(textTime);
    showTime = DateFormat('d/MM/yyyy, hh:mm a').format(dateTime);
  } else {
    showTime = "";
  }

  return showTime;
}
