import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/presentations/manager/list_teacher_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/presentations/widgets/body_add_teacher_to_course.dart';

class AddTeacherToCoursePage extends StatefulWidget {
  static const String routeName = "/AddTeacherToCoursePage";
  AddTeacherToCoursePage({Key? key}) : super(key: key);

  @override
  _AddTeacherToCoursePageState createState() => _AddTeacherToCoursePageState();
}

class _AddTeacherToCoursePageState extends State<AddTeacherToCoursePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Add teacher to the course",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: buildBody(context));
  }

  BlocProvider<ListTeacherBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<ListTeacherBloc>(), child: BodyAddTeacherToCourse());
  }
}
