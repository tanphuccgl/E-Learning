import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/get_current_user.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/widgets/body_get_course.dart';

class GetCoursePage extends StatefulWidget {
  const GetCoursePage({Key? key}) : super(key: key);

  @override
  _GetCoursePageState createState() => _GetCoursePageState();
}

class _GetCoursePageState extends State<GetCoursePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<GetCourseBloc>(),
        child: BodyGetCourse(changeWithPage: "GetCoursePage",),
    );
  }


}
