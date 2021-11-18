import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_exercise_by_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_course/get_exercise_by_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_course/get_exercise_by_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_course/get_exercise_by_course_state.dart';

class ExercisePage extends StatefulWidget {
  final String? idCourse;

  const ExercisePage({Key? key, this.idCourse}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
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
      height: size.width / 0.66,
      child: Padding(
        padding: EdgeInsets.only(
            left: size.width / 25,
            right: size.width / 25,
            top: size.width / 10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _item(
                time:
                    "${DateFormat('yyyy-MM-ddThh:mm').parse(list![index].allowSubmission!)} - ${list?[index].submissionDeadline}",
                titleExercise: list?[index].titleExercise,
                descriptionExercise: list?[index].descriptionExercise);
          },
          itemCount: list?.length,
        ),
      ),
    );
  }

  Widget _item(
      {String? time, String? titleExercise, String? descriptionExercise}) {
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
            descriptionExercise: descriptionExercise),
      ],
    );
  }

  Widget _card(
      {String? time, String? titleExercise, String? descriptionExercise}) {
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
                        onPressed: () {},
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
