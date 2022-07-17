import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_member_in_course/get_member_in_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_point_student/get_point_student_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_point_teacher/get_point_teacher_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/pages/list_score_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/pages/list_stud_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_course/get_exercise_by_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/execise_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/title_header.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/pages/home_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/manager/get_all_lecture_of_course/get_all_lecture_of_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/pages/lecture_page.dart';

class DetailCoursePage extends StatefulWidget {
  final String? idCourse;
  final String? nameCourse;
  final int? widgetId;
  final int? choosingPos;
  static const String routeName = "/DetailCoursePage";

  const DetailCoursePage(
      {Key? key,
      this.choosingPos,
      this.idCourse,
      this.nameCourse,
      this.widgetId})
      : super(key: key);

  @override
  _DetailCoursePageState createState() => _DetailCoursePageState();
}

class _DetailCoursePageState extends State<DetailCoursePage> {
  int? curentWidgetId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.widgetId != null) {
      curentWidgetId = widget.widgetId;
    } else {
      curentWidgetId = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.width / 7),
        child: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage()))),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            widget.nameCourse!,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size.width / 15),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: Container(
        height: size.height - size.width / 7,
        width: size.width,
        child: Column(children: [
          Container(
            child: TitleHeader(
              onChanged: (e) {
                setState(() {
                  curentWidgetId = e;
                });
              },
              choosingPos1: widget.choosingPos,
            ),
          ),
          Container(
              height: size.height - size.width / 7 - size.width / 5,
              width: size.width,
              child: getWidgetById(curentWidgetId)),
        ]),
      ),
    );
  }

  Widget getWidgetById(int? id) {
    switch (id) {
      case 1:
        return BlocProvider(
          create: (_) => sl<GetAllLectureBloc>(),
          child: LecturePage(
            idCourse: widget.idCourse,
            nameCourse: widget.nameCourse,
          ),
        );

      case 2:
        return BlocProvider(
          create: (_) => sl<GetExerciseByCourseBloc>(),
          child: ExercisePage(
            idCourse: widget.idCourse,
            nameCourse: widget.nameCourse,
          ),
        );

      case 3:
        return BlocProvider(
          create: (_) => sl<GetMemberInCourseBloc>(),
          child: ListStudentPage(
            idCourse: widget.idCourse,
          ),
        );
      case 4:
        return BlocProvider(
          create: (_) => sl<GetPointStudentBloc>(),
          child: ListScorePage(
            idCourse: widget.idCourse,
          ),
        );
      // case 5:
      //   return Container();
    }
    return Container();
  }
}
