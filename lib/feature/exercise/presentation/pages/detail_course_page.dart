import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_member_in_course/get_member_in_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/pages/list_stud_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_course/get_exercise_by_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/execise_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/title_header.dart';

class DetailCoursePage extends StatefulWidget {
  final String? idCourse;
  final String? nameCourse;

  static const String routeName = "/DetailCoursePage";

  const DetailCoursePage({Key? key,this.idCourse,this.nameCourse}) : super(key: key);

  @override
  _DetailCoursePageState createState() => _DetailCoursePageState();
}

class _DetailCoursePageState extends State<DetailCoursePage> {
  int? curentWidgetId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    curentWidgetId = 1;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.width/7),
        child: AppBar(
          backgroundColor: Colors.transparent,
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
      body: Column(children: [
        TitleHeader(
          onChanged: (e) {
            setState(() {
              curentWidgetId = e;
            });
          },
        ),
        getWidgetById(curentWidgetId),
      ]),
    );
  }

  Widget getWidgetById(int? id) {
    switch (id) {
      case 1:
      // return BlocProvider(
      //   create: (_) => moodleDI<CourseContentBloc>(),
      //   child: Lecture(
      //     idCourse: widget.idCourse,
      //   ),
      // );
        return Container();

      case 2:
      return BlocProvider(
        create: (_) => sl<GetExerciseByCourseBloc>(),
        child: ExercisePage(
          idCourse: widget.idCourse,
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
        return Container();
      case 5:
        return Container();
    }
    return Container();
  }
}
